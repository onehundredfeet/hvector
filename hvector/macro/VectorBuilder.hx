package hvector.macro;

#if macro
import haxe.macro.Expr;
import haxe.macro.MacroStringTools;
import haxe.macro.TypeTools;
import haxe.macro.Context;

using haxe.macro.TypeTools;
using hvector.macro.Extensions;
using haxe.macro.ComplexTypeTools;

class VectorBuilder {
	static final VECF_NAME = "hvector.Float";
	static final VECS_NAME = "hvector.Vec";
	static final VECI_NAME = "hvector.Int";

	static function getVectorTypePrefix(fp:Bool, bits64:Bool) {
		return (fp ? (bits64 ? VECF_NAME : VECS_NAME) : VECI_NAME);
	}

	private static function makeReturnStatement(name:String, originalType:ComplexType, fp:Bool, double:Bool, depth:Int):Expr {
		var tname =getVectorTypePrefix(fp, double) + depth;
		var tthis = macro $i{"this"};
		var aa:Array<Expr> = [tthis.field(name + "_x"), tthis.field(name + "_y")];
		if (depth >= 3)
			aa.push(tthis.field(name + "_z"));
		if (depth >= 4)
			aa.push(tthis.field(name + "_w"));

		var tp:TypePath = switch (originalType) {
			case TPath(p): p;
			default: Context.fatalError("Type is not a type path", Context.currentPos());
		}

		return macro return new $tp($a{aa});
	}

	private static function makeGetFunction(name:String, originalType:ComplexType, fp:Bool, double:Bool, depth:Int):Function {
		var tname = getVectorTypePrefix(fp, double) + depth;

		var myFunc:Function = {
			expr: makeReturnStatement(name, originalType, fp, double, depth),
			ret: originalType, // ret = return type
			args: [] // no arguments here
		}

		return myFunc;
	}

	private static function makeSetFunction(name:String, originalType:ComplexType, fp:Bool, double:Bool, depth:Int, addReturn:Bool):Function {
		var tname = getVectorTypePrefix(fp, double) + depth;
		var tthis = macro $i{"this"};
		var vname = macro $i{"v"};

		var aa:Array<Expr> = [
			tthis.field(name + "_x").assign(vname.field("x")),
			tthis.field(name + "_y").assign(vname.field("y"))
		];
		if (depth >= 3)
			aa.push(tthis.field(name + "_z").assign(vname.field("z")));
		if (depth >= 4)
			aa.push(tthis.field(name + "_w").assign(vname.field("w")));

		if (addReturn) {
			aa.push(makeReturnStatement(name, originalType, fp, double, depth));
		}

		var tp:TypePath = tname.asTypePath();

		var myArg:FunctionArg = {
			name: "v",
			type: TPath(tp) // originalType
		}
		var args:Array<FunctionArg> = [myArg];

		var myFastSetFunc:Function = {
			expr: aa.toBlock(), // actual value
			ret: null, // ret = return type
			args: args // vector4 incoming
		}
		// Exprs.log(myFastSetFunc.expr);

		return myFastSetFunc;
	}

	macro static public function float4(vname:String):Array<Field> {
		return addVector(vname, macro :Float4, true, true, 4);
	}

	macro static public function float3(vname:String):Array<Field> {
		return addVector(vname, macro :Float3, true, true, 3);
	}

	macro static public function float2(vname:String):Array<Field> {
		return addVector(vname, macro :Float2, true, true, 2);
	}

	macro static public function vec4(vname:String):Array<Field> {
		return addVector(vname, macro :Vec4, true, false, 4);
	}

	macro static public function vec3(vname:String):Array<Field> {
		return addVector(vname, macro :Vec3, true, false, 3);
	}

	macro static public function vec2(vname:String):Array<Field> {
		return addVector(vname, macro :Vec2, true, false, 2);
	}

	static function addVector(vname:String, originalType:ComplexType, fp:Bool, bits64:Bool, depth:Int):Array<Field> {
		var fields = Context.getBuildFields();

		for (f in declareVector(vname, originalType, fp, bits64, depth)) {
			fields.push(f);
		}
		return fields;
	}

	// must return into a program , not a value
	static public function declareVector(vname:String, originalType:ComplexType, fp:Bool, bits64:Bool, depth:Int, isPublic = true, ?m:Metadata):Array<Field> {
		// get existing fields from the context from where build() is called
		var fields = [];
		var value = 0.0;
		var pos = Context.currentPos();
		var fieldName = vname;

		var myGetFunc = makeGetFunction(vname, originalType, fp, bits64, depth);

		// create: `public var $fieldName(get,null)`
		var propertyField:Field = {
			name: fieldName,
			access: isPublic ? [Access.APublic] : [],
			meta: m,
			kind: FieldType.FProp("get", "set", myGetFunc.ret),
			pos: pos,
		};

		// create: `public inline function get_$fieldName() return $value`
		var getterField:Field = {
			name: "get_" + fieldName,
			access: [Access.APrivate, Access.AInline],
			kind: FieldType.FFun(myGetFunc),
			pos: pos,
		};

		// Not using the regular set_ as it allocates
		// create: `private inline function set$fieldName() return $value`
		var setterField:Field = {
			name: "set_" + fieldName,
			access: [Access.APrivate, Access.AInline],
			//        kind: FieldType.FFun(mySetFunc),
			kind: FieldType.FFun(makeSetFunction(vname, originalType, fp, bits64, depth, true)),
			pos: pos,
		};

		/*
			var fastSetterField:Field = {
				name: "set" + fieldName,
				access: [Access.APublic, Access.AInline],
				// kind: FieldType.FFun(myFastSetFunc),
				kind: FieldType.FFun(makeSetFunction(vname, bits64, depth, false)),
				pos: pos,
			};
		 */
		var list = ["x", "y"];
		if (depth >= 3)
			list.push("z");
		if (depth >= 4)
			list.push("w");

		var ekind = fp ? (bits64 ? macro :Float : macro :Single) : (bits64 ? macro :haxe.Int64 : macro :Int);
		for (v in list) {
			var componentField:Field = {
				name: fieldName + "_" + v,
				access: isPublic ? [Access.APublic] : [],
				kind: FieldType.FVar(ekind),
				pos: pos
			}
			fields.push(componentField);
		}

		// append both fields
		fields.push(propertyField);
		fields.push(getterField);
		fields.push(setterField);
		// fields.push(fastSetterField);

		// trace(fields);
		return fields;
	}

	static public function embed():Array<Field> {
		var fields = Context.getBuildFields();
		try {
			var newFields = [];

			final tv2 = (macro :hvector.Vec2.Vec2Data).toType();
			final tv3 = (macro :hvector.Vec3.Vec3Data).toType();
			final tv4 = (macro :hvector.Vec4.Vec4Data).toType();
			final tf2 = (macro :hvector.Float2.Float2Data).toType();
			final tf3 = (macro :hvector.Float3.Float3Data).toType();
			final tf4 = (macro :hvector.Float4.Float4Data).toType();
			final ti2 = (macro :hvector.Int2.Int2Data).toType();
			final ti3 = (macro :hvector.Int3.Int3Data).toType();
			final ti4 = (macro :hvector.Int4.Int4Data).toType();

			for (f in fields) {
				var replaced = false;
				var isPublic = (f.access == null || f.access.contains(APublic)) ? true : false;

				switch (f.kind) {
					case FVar(ct, e):
						//						trace('Embedding ${f.name} on ${Context.getLocalClass().get().name}');
						var t:haxe.macro.Type = null;

						if (ct == null) {
							var to = Context.typeof(e);
							if (to != null) {
								to = to.follow();
								var vectorType = false;

								if (Context.unify(tv2, to) || Context.unify(tv3, to) || Context.unify(tv4, to)) {
									vectorType = true;
								} else if (Context.unify(tf2, to) || Context.unify(tf3, to) || Context.unify(tf4, to)) {
									vectorType = true;
								} else if (Context.unify(ti2, to) || Context.unify(ti3, to) || Context.unify(ti4, to)) {
									vectorType = true;
								}

								if (vectorType) {
									t = to;
								} else {
									// Context.warning('Embedded type is not a vector: ${f.name} have ${to} ${to.followWithAbstracts()}', f.pos);
								}
								//							Context.fatalError('For now, vector embedding requires all fields have an explicite type: ${f.name} have ${to} ${to.followWithAbstracts()}', f.pos);
							}
						} else {
							t = Context.resolveType(ct, Context.currentPos());
						}
						if (t != null) {
							var originalType = t.toComplexType();

							if (originalType.toString() != "Any") {
								t = t.followWithAbstracts();
								replaced = true;
								if (Context.unify(t, tf2))
									for (vf in declareVector(f.name, originalType, true, true, 2, isPublic, f.meta))
										newFields.push(vf);
								else if (Context.unify(t, tf3))
									for (vf in declareVector(f.name, originalType, true, true, 3, isPublic, f.meta))
										newFields.push(vf);
								else if (Context.unify(t, tf4))
									for (vf in declareVector(f.name, originalType, true, true, 4, isPublic, f.meta))
										newFields.push(vf);
								else if (Context.unify(t, tv2))
									for (vf in declareVector(f.name, originalType, true, false, 2, isPublic, f.meta))
										newFields.push(vf);
								else if (Context.unify(t, tv3))
									for (vf in declareVector(f.name, originalType, true, false, 3, isPublic, f.meta))
										newFields.push(vf);
								else if (Context.unify(t, tv4))
									for (vf in declareVector(f.name, originalType, true, false, 4, isPublic, f.meta))
										newFields.push(vf);
								else if (Context.unify(t, ti2))
									for (vf in declareVector(f.name, originalType, false, false, 2, isPublic, f.meta))
										newFields.push(vf);
								else if (Context.unify(t, ti3))
									for (vf in declareVector(f.name, originalType, false, false, 3, isPublic, f.meta))
										newFields.push(vf);
								else if (Context.unify(t, ti4))
									for (vf in declareVector(f.name, originalType, false, false, 4, isPublic, f.meta))
										newFields.push(vf);
								else {
									// Context.warning('Ignoring ${f.name} is not find vector type, but found ${t}', f.pos);
									replaced = false;
								}
							} else {
								replaced = false;
							}
						} else {
							// /Context.warning('Ignoring ${f.name} is not find vector type', f.pos);
						}

					default:
				}

				if (!replaced) {
					newFields.push(f);
				}
			}

			var m = Context.getLocalClass().get().meta;
			if (m.has(":vbprint")) {
				var printer = new haxe.macro.Printer();
				trace('new fields ${newFields.length} vs ${fields.length}');
				for (f in newFields) {
					trace('${printer.printField(f)}');
				}
			}

			return newFields;
		} catch (e) {
			Context.error('Could not embed vectors message: ${e.message} details: ${e.details()}', Context.currentPos());
			Context.fatalError('Stack ${e.stack}', Context.currentPos());
			return null;
		}
	}
}
#end

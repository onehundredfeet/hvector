package hvector.macro;

#if macro
import haxe.macro.Expr;
import haxe.macro.MacroStringTools;
import haxe.macro.TypeTools;
import haxe.macro.Context;

using haxe.macro.TypeTools;

using hvector.macro.Extensions;

class VectorBuilder {
	static final VECF_NAME = "hvector.Float";
	static final VEC_NAME = "hvector.Vec";
	static final VECI_NAME = "hvector.Int";

	private static function makeReturnStatement(name:String, double:Bool, depth:Int):Expr {
		var tname = (double ? VECF_NAME : VEC_NAME) + depth;
		var tthis = macro $i{"this"};
		var aa:Array<Expr> = [tthis.field( name + "_x"), tthis.field( name + "_y")];
		if (depth >= 3)
			aa.push(tthis.field( name + "_z"));
		if (depth >= 4)
			aa.push(tthis.field( name + "_w"));

		var tp:TypePath = tname.asTypePath();

		return macro return new $tp($a{aa});
	}

	private static function makeGetFunction(name:String, double:Bool, depth:Int):Function {
		var tname = (double ? VECF_NAME : VEC_NAME) + depth;

		var myFunc:Function = {
			expr: makeReturnStatement(name, double, depth),
			ret: tname.asComplexType(), // ret = return type
			args: [] // no arguments here
		}

		return myFunc;
	}

	private static function makeSetFunction(name:String, double:Bool, depth:Int, addReturn:Bool):Function {
		var tname = (double ? VECF_NAME : VEC_NAME) + depth;
		var tthis = macro $i{"this"};
		var vname = macro $i{"v"};

		var aa:Array<Expr> = [
			tthis.field( name + "_x").assign( vname.field( "x")),
			tthis.field( name + "_y").assign( vname.field( "y"))
		];
		if (depth >= 3)
			aa.push(tthis.field( name + "_z").assign( vname.field( "z")));
		if (depth >= 4)
			aa.push(tthis.field( name + "_w").assign( vname.field( "w")));

		if (addReturn) {
			aa.push(makeReturnStatement(name, double, depth));
		}

		var tp:TypePath = tname.asTypePath();

		var myArg:FunctionArg = {
			name: "v",
			type: tname.asComplexType()
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
		return addVector(vname, true, 4);
	}

	macro static public function float3(vname:String):Array<Field> {
		return addVector(vname, true, 3);
	}

	macro static public function float2(vname:String):Array<Field> {
		return addVector(vname, true, 2);
	}

	macro static public function fec4(vname:String):Array<Field> {
		return addVector(vname, false, 4);
	}

	macro static public function vec3(vname:String):Array<Field> {
		return addVector(vname, false, 3);
	}

	macro static public function vec2(vname:String):Array<Field> {
		return addVector(vname, false, 2);
	}

	static function addVector(vname:String, doubles:Bool, depth:Int):Array<Field> {
		var fields = Context.getBuildFields();

		for (f in declareVector(vname, doubles, depth)) {
			fields.push(f);
		}
		return fields;
	}

	// must return into a program , not a value
	static public function declareVector(vname:String, doubles:Bool, depth:Int, isPublic = true, ?m:Metadata):Array<Field> {
		// get existing fields from the context from where build() is called
		var fields = [];
		var value = 0.0;
		var pos = Context.currentPos();
		var fieldName = vname;

		var myGetFunc = makeGetFunction(vname, doubles, depth);

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
			kind: FieldType.FFun(makeSetFunction(vname, doubles, depth, true)),
			pos: pos,
		};

		/*
		var fastSetterField:Field = {
			name: "set" + fieldName,
			access: [Access.APublic, Access.AInline],
			// kind: FieldType.FFun(myFastSetFunc),
			kind: FieldType.FFun(makeSetFunction(vname, doubles, depth, false)),
			pos: pos,
		};
		*/
		var list = ["x", "y"];
		if (depth >= 3)
			list.push("z");
		if (depth >= 4)
			list.push("w");

		for (v in list) {
			var componentField:Field = {
				name: fieldName + "_" + v,
				access: isPublic ? [Access.APublic] : [],
				kind: FieldType.FVar(doubles? macro:Float : macro:Single),
				pos: pos
			}
			fields.push(componentField);
		}

		// append both fields
		fields.push(propertyField);
		fields.push(getterField);
		fields.push(setterField);
		//fields.push(fastSetterField);

		// trace(fields);
		return fields;
	}

	static public function embed():Array<Field> {
		var fields = Context.getBuildFields();
		try {
			var newFields = [];

			for (f in fields) {
				var replaced = false;
				var isPublic = (f.access == null || f.access.contains(APublic)) ? true : false;

				switch (f.kind) {
					case FVar(ct, e):
//						trace('Embedding ${f.name} on ${Context.getLocalClass().get().name}');
						var t:haxe.macro.Type = null;

						t = Context.resolveType(ct, Context.currentPos());
						if (t != null) {
							t = t.follow();

							var tt = t.toString();
							replaced = true;
							switch (tt) {
								case "hvector.Float2": for (vf in declareVector(f.name, true, 2, isPublic, f.meta))
										newFields.push(vf);
								case "hvector.Float3": for (vf in declareVector(f.name, true, 3, isPublic, f.meta))
										newFields.push(vf);
								case "hvector.Float4": for (vf in declareVector(f.name, true, 4, isPublic, f.meta))
										newFields.push(vf);
								case "hvector.Vec2": for (vf in declareVector(f.name, false, 2, isPublic, f.meta))
										newFields.push(vf);
								case "hvector.Vec3": for (vf in declareVector(f.name, false, 3, isPublic, f.meta))
										newFields.push(vf);
								case "hvector.Vec4": for (vf in declareVector(f.name, false, 4, isPublic, f.meta))
										newFields.push(vf);
								default:
									replaced = false;
							}
						} else {
							trace('Could not find type ${t.toString()}');
						}

					default:
				}

				if (!replaced) {
					newFields.push(f);
				}
			}
			/*
				  var printer = new haxe.macro.Printer();
				  trace('new fields ${newFields.length} vs ${fields.length}');
				  for (f in newFields) {
				trace ('${printer.printField(f)}');
				  }
			 */

			return newFields;
		} catch (e) {
			Context.error('Could not embed vectors', Context.currentPos());
			return null;
		}
	}
}
#end

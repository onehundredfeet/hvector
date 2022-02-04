package hvector;

#if macro
import haxe.macro.Expr;
import haxe.macro.MacroStringTools;
import haxe.macro.Context;

using haxe.macro.TypeTools;
using tink.MacroApi;
#end

final VECF_NAME = "hvector.Float";
final VEC_NAME = "hvector.Vec";

private function MakeReturnStatement(name:String, double:Bool, depth:Int):Expr {
	var tname = (double ? VECF_NAME : VEC_NAME) + depth;
	var tthis = macro $i{"this"};
	var aa:Array<Expr> = [Exprs.field(tthis, name + "_x"), Exprs.field(tthis, name + "_y")];
	if (depth >= 3)
		aa.push(Exprs.field(tthis, name + "_z"));
	if (depth >= 4)
		aa.push(Exprs.field(tthis, name + "_w"));

	var tp:TypePath = Types.asTypePath(tname);

	return macro return new $tp($a{aa});
}

private function MakeGetFunction(name:String, double:Bool, depth:Int):Function {
	var tname = (double ? VECF_NAME : VEC_NAME) + depth;

	var myFunc:Function = {
		expr: MakeReturnStatement(name, double, depth),
		ret: Types.asComplexType(tname), // ret = return type
		args: [] // no arguments here
	}

	return myFunc;
}

private function MakeSetFunction(name:String, double:Bool, depth:Int, addReturn:Bool):Function {
	var tname = (double ? VECF_NAME : VEC_NAME) + depth;
	var tthis = macro $i{"this"};
	var vname = macro $i{"v"};

	var aa:Array<Expr> = [
		Exprs.assign(Exprs.field(tthis, name + "_x"), Exprs.field(vname, "x")),
		Exprs.assign(Exprs.field(tthis, name + "_y"), Exprs.field(vname, "y"))
	];
	if (depth >= 3)
		aa.push(Exprs.assign(Exprs.field(tthis, name + "_z"), Exprs.field(vname, "z")));
	if (depth >= 4)
		aa.push(Exprs.assign(Exprs.field(tthis, name + "_w"), Exprs.field(vname, "w")));

	if (addReturn) {
		aa.push(MakeReturnStatement(name, double, depth));
	}

	var tp:TypePath = Types.asTypePath(tname);

	var myArg:FunctionArg = {
		name: "v",
		type: Types.asComplexType(tname)
	}
	var args:Array<FunctionArg> = [myArg];

	var myFastSetFunc:Function = {
		expr: Exprs.toBlock(aa), // actual value
		ret: null, // ret = return type
		args: args // vector4 incoming
	}
	// Exprs.log(myFastSetFunc.expr);

	return myFastSetFunc;
}

function Float4(vname:String):Array<Field> {
	return AddVector(vname, true, 4);
}

function Float3(vname:String):Array<Field> {
	return AddVector(vname, true, 3);
}

function Float2(vname:String):Array<Field> {
	return AddVector(vname, true, 2);
}

function Vec4(vname:String):Array<Field> {
	return AddVector(vname, false, 4);
}

function Vec3(vname:String):Array<Field> {
	return AddVector(vname, false, 3);
}

function Vec2(vname:String):Array<Field> {
	return AddVector(vname, false, 2);
}

function AddVector(vname:String, doubles:Bool, depth:Int):Array<Field> {
	var fields = Context.getBuildFields();

	for (f in declareVector(vname, doubles, depth)) {
		fields.push(f);
	}
	return fields;
}

// must return into a program , not a value
function declareVector(vname:String, doubles:Bool, depth:Int, isPublic = true, ?m:Metadata):Array<Field> {
	// get existing fields from the context from where build() is called
	var fields = [];
	var value = 0.0;
	var pos = Context.currentPos();
	var fieldName = vname;

	var myGetFunc = MakeGetFunction(vname, doubles, depth);

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
		kind: FieldType.FFun(MakeSetFunction(vname, doubles, depth, true)),
		pos: pos,
	};

	var fastSetterField:Field = {
		name: "set" + fieldName,
		access: [Access.APublic, Access.AInline],
		// kind: FieldType.FFun(myFastSetFunc),
		kind: FieldType.FFun(MakeSetFunction(vname, doubles, depth, false)),
		pos: pos,
	};

	var list = ["x", "y"];
	if (depth >= 3)
		list.push("z");
	if (depth >= 4)
		list.push("w");

	for (v in list) {
		var componentField:Field = {
			name: fieldName + "_" + v,
			access: isPublic ? [Access.APublic] : [],
			kind: FieldType.FVar(macro:Float),
			pos: pos
		}
		fields.push(componentField);
	}

	// append both fields
	fields.push(propertyField);
	fields.push(getterField);
	fields.push(setterField);
	fields.push(fastSetterField);

	// trace(fields);
	return fields;
}

function embed():Array<Field> {
	var fields = Context.getBuildFields();
	var newFields = [];

	for (f in fields) {
		var replaced = false;
		var isPublic = (f.access == null || f.access.contains(APublic)) ? true : false;

		switch (f.kind) {
			case FVar(ct, e):
				var t:haxe.macro.Type = null;

				if (ct == null) {
					var testType = e.typeof();
					if (testType.isSuccess()) {
						t = testType.sure();
					}
				} else {
					t = Context.resolveType(ct, Context.currentPos());
				}
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
						case "hvector.Vec2": for (vf in declareVector(f.name, true, 2, isPublic, f.meta))
								newFields.push(vf);
						case "hvector.Vec3": for (vf in declareVector(f.name, true, 3, isPublic, f.meta))
								newFields.push(vf);
						case "hvector.Vec4": for (vf in declareVector(f.name, true, 4, isPublic, f.meta))
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
}

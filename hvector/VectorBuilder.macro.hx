package hvector;

import tink.macro.Types;
import tink.MacroApi.ClassBuilder;
import tink.macro.Exprs;
import haxe.macro.Expr;
import haxe.macro.MacroStringTools;
import haxe.macro.Context;
import tink.macro.Functions;


  final VECF_NAME = "hvector.Float";
  final VEC_NAME = "hvector.Vec";

    private function MakeReturnStatement(name : String, double : Bool, depth : Int ):Expr {
      var tname = (double ?  VECF_NAME : VEC_NAME) + depth;
      var tthis = macro $i{"this"};
      var aa : Array<Expr> = [ Exprs.field(tthis, name + "_x"), Exprs.field(tthis, name + "_y") ];
      if (depth >= 3) aa.push(Exprs.field(tthis, name + "_z"));
      if (depth >= 4) aa.push(Exprs.field(tthis, name + "_w"));
      
      var tp : TypePath = Types.asTypePath(tname);

      return macro return new $tp( $a{aa});
    }
    private function MakeGetFunction(name : String, double : Bool, depth : Int) : Function{
      var tname = (double ?  VECF_NAME :VEC_NAME) + depth;

      var myFunc:Function = { 
        expr: MakeReturnStatement(name, double, depth),
        ret: Types.asComplexType(tname), // ret = return type
        args:[] // no arguments here
      }

      return myFunc;
    }

    private function MakeSetFunction(name : String, double : Bool, depth : Int, addReturn : Bool) : Function{
      var tname = (double ?  VECF_NAME : VEC_NAME) + depth;
      var tthis = macro $i{"this"};
      var vname = macro $i{"v"};

      

      var aa : Array<Expr> = [ 
        Exprs.assign(Exprs.field(tthis, name + "_x"), Exprs.field(vname,"x")),
        Exprs.assign(Exprs.field(tthis, name + "_y"), Exprs.field(vname,"y")) 
      ];
      if (depth >= 3) aa.push(Exprs.assign(Exprs.field(tthis, name + "_z"), Exprs.field(vname,"z")));
      if (depth >= 4) aa.push(Exprs.assign(Exprs.field(tthis, name + "_w"), Exprs.field(vname,"w")));

      if (addReturn) {
        aa.push(MakeReturnStatement(name, double, depth));
      }

      var tp : TypePath = Types.asTypePath(tname);

      var myArg:FunctionArg = {
        name: "v",
        type: Types.asComplexType(tname)
      }
      var args:Array<FunctionArg> = [myArg];
      
      var myFastSetFunc:Function = { 
        expr: Exprs.toBlock(aa),  // actual value
        ret: null, // ret = return type
        args:args // vector4 incoming
      }
      //Exprs.log(myFastSetFunc.expr);

      return myFastSetFunc;
    }


    function Float4(vname : String):Array<Field> {
      return DeclareVector(vname, true, 4);
    }
    function Float3(vname : String):Array<Field> {
      return DeclareVector(vname, true, 3);
    }
    function Float2(vname : String):Array<Field> {
      return DeclareVector(vname, true, 2);
    }
    function Vec4(vname : String):Array<Field> {
      return DeclareVector(vname, false, 4);
    }
    function Vec3(vname : String):Array<Field> {
      return DeclareVector(vname, false, 3);
    }
    function Vec2(vname : String):Array<Field> {
      return DeclareVector(vname, false, 2);
    }
    // must return into a program , not a value
    function DeclareVector(vname : String, doubles : Bool, depth : Int):Array<Field> {
    // get existing fields from the context from where build() is called
    var fields = Context.getBuildFields();
    var value = 0.0;
    var pos = Context.currentPos();
    var fieldName = vname;
    
 
    var myGetFunc = MakeGetFunction(vname, doubles, depth);

    // create: `public var $fieldName(get,null)`
    var propertyField:Field = {
      name:  fieldName,
      access: [Access.APublic],
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
    
    //Not using the regular set_ as it allocates
    // create: `private inline function set$fieldName() return $value`
      var setterField:Field = {
        name: "set_" + fieldName,
        access: [Access.APrivate, Access.AInline],
//        kind: FieldType.FFun(mySetFunc),
        kind:FieldType.FFun(MakeSetFunction(vname, doubles, depth, true)),
        pos: pos,
      };
      
      var fastSetterField:Field = {
        name: "set" + fieldName,
        access: [Access.APublic, Access.AInline],
        //kind: FieldType.FFun(myFastSetFunc),
        kind:FieldType.FFun(MakeSetFunction(vname, doubles, depth, false)),
        pos: pos,
      };

      var list = ["x", "y"];
      if (depth >= 3) list.push("z");
      if (depth >= 4) list.push("w");
      
      for (v in list) {
          var componentField: Field = {
            name: fieldName + "_" + v,
            access: [Access.APublic],
            kind: FieldType.FVar(macro : Float),
            pos: pos
        }
        fields.push(componentField);
      }
    
    // append both fields
    fields.push(propertyField);
    fields.push(getterField);
    fields.push(setterField);
    fields.push(fastSetterField);
    

    //trace(fields);
    return fields;
  }


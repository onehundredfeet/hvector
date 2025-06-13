package hvector.native;

#if hvector_math

// extern class ExternStruct
// {
//    @:native("~ExternStruct")
//    public function destroy():Void;

//    @:native("new ExternStruct")
//    public static function create():cpp.Pointer<ExternStruct>;
// }




#if cpp

@:noCompletion
@:struct
@:native("::math::float3")
@:include("math/vector/float.hpp")
@:notNull
@:structAccess
@:unreflective
@:build(idl.macros.MacroTools.buildHXCPPIDLType("${HVECTOR_IDL_DIR}/hvector.idl", false)) 
extern class Single3Data {
	public var x: Single;
	public var y: Single;
	public var z: Single;
  public var w: Single;


	public inline function toString():String {
        return 'Single3(' + this.x + ', ' + this.y + ', ' + this.z + ', ' + this.w + ')';
    }

    @:native("::math::float3")
    extern public static function make():Single3 ;

    @:native("::math::float3::operator*")
    extern public function mulVec( b : Single3Data):Single3Data;
    
}


@:forward
@:forwardStatics
@:notNull
@:unreflective
abstract Single3 (Single3Data) to Single3Data from Single3Data {
    @:functionCode("return ::math::float3(0.0f, 0.0f, 0.0f, 0.0f);")
    public static function zero():Single3 {
        return Single3Data.make();
    }

    @:functionCode("return ::math::float3(1.0f, 1.0f, 1.0f, 1.0f);")
    public static function one():Single3 {
        return Single3Data.make();
    }

    @:op(A * B)
    public static inline function multiplyVec(a:Single3,b:Single3):Single3 {
        return a.mulVec(b);
    }

    public inline function assign(x:Single, y:Single, z:Single):Single3 {
		this.x = x;
		this.y = y;
		this.z = z;
		return this;
	}

}


#else

typedef Single3Data = hvector.Vec3Data;
typedef Single3S = hvector.Vec3;

#end


// class Single3DataWrapper
// {
//     //var pointer:cpp.Pointer<ExternStruct>;
//     // public static var instances:Int = 0;

//     // public function new()
//     // {
//     //    pointer = ExternStruct.create();
//     //    instances++;
//     //    cpp.vm.Gc.setFinalizer(this, cpp.Function.fromStaticFunction(destroy));
//     // }

//     // @:void static public function destroy(ExternWrapper : ExternWrapper) : Void {
//     //    instances--;
// 	//  	 ExternWrapper.pointer.destroy();
//     // }
// }

#end
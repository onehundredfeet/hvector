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
@:native("::math::float2")
@:include("math/vector/float.hpp")
@:notNull
@:structAccess
@:unreflective
@:build(idl.macros.MacroTools.buildHXCPPIDLType("${HVECTOR_IDL_DIR}/hvector.idl", false)) 
extern class Single2Data {
	public var x: Single;
	public var y: Single;
	public var z: Single;
  public var w: Single;


	public inline function toString():String {
        return 'Single2(' + this.x + ', ' + this.y + ', ' + this.z + ', ' + this.w + ')';
    }

    @:native("::math::float2")
    extern public static function make():Single2 ;

    @:native("::math::float2::operator*")
    extern public function mulVec( b : Single2Data):Single2Data;
    
}


@:forward
@:forwardStatics
@:notNull
@:unreflective
abstract Single2 (Single2Data) to Single2Data from Single2Data {
    @:functionCode("return ::math::float2(0.0f, 0.0f, 0.0f, 0.0f);")
    public static function zero():Single2 {
        return Single2Data.make();
    }

    @:functionCode("return ::math::float2(1.0f, 1.0f, 1.0f, 1.0f);")
    public static function one():Single2 {
        return Single2Data.make();
    }

    @:op(A * B)
    public static inline function multiplyVec(a:Single2,b:Single2):Single2 {
        return a.mulVec(b);
    }

    public inline function assign(x:Single, y:Single, z:Single):Single2 {
		this.x = x;
		this.y = y;
		this.z = z;
		return this;
	}

}


#else

typedef Single2Data = hvector.Vec3Data;
typedef Single3S = hvector.Vec3;

#end


// class Single2DataWrapper
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
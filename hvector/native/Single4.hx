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
@:native("::math::float4")
@:include("math/vector/float.hpp")
@:notNull
@:structAccess
@:unreflective
@:build(idl.macros.MacroTools.buildHXCPPIDLType("${HVECTOR_IDL_DIR}/hvector.idl", false)) 
extern class Single4Data {
	public var x: Single;
	public var y: Single;
	public var z: Single;
  public var w: Single;


	public inline function toString():String {
        return 'Single4(' + this.x + ', ' + this.y + ', ' + this.z + ', ' + this.w + ')';
    }

    @:native("::math::float4")
    extern public static function make():Single4 ;

    @:native("::math::float4::operator*")
    extern public function mulVec( b : Single4Data):Single4Data;
    
}


@:forward
@:forwardStatics
@:notNull
@:unreflective
abstract Single4 (Single4Data) to Single4Data from Single4Data {
    @:functionCode("return ::math::float4(0.0f, 0.0f, 0.0f, 0.0f);")
    public static function zero():Single4 {
        return Single4Data.make();
    }

    @:functionCode("return ::math::float4(1.0f, 1.0f, 1.0f, 1.0f);")
    public static function one():Single4 {
        return Single4Data.make();
    }

    @:op(A * B)
    public static inline function multiplyVec(a:Single4,b:Single4):Single4 {
        return a.mulVec(b);
    }

    public inline function assign(x:Single, y:Single, z:Single):Single4 {
		this.x = x;
		this.y = y;
		this.z = z;
		return this;
	}

}


#else

typedef Single4Data = hvector.Vec3Data;
typedef Single3S = hvector.Vec3;

#end


// class Single4DataWrapper
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
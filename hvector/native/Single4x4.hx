package hvector.native;

#if hvector_math

// extern class ExternStruct
// {
//    @:native("~ExternStruct")
//    public function destroy():Void;

//    @:native("new ExternStruct")
//    public static function create():cpp.Pointer<ExternStruct>;
// }


import hvector.native.Single4;

#if cpp

@:noCompletion
@:struct
@:native("::math::float4x4")
@:include("math/matrix/float.hpp")
@:notNull
@:structAccess
@:unreflective

extern class Single4x4Data {
    var c0 : Single4; 
	var c1 : Single4; 
	var c2 : Single4; 
	var c3 : Single4;

    static final identity:Single4x4Data;

	public inline function toString():String {
        return 'Single4x4(' + this.c0.toString() + ', ' + this.c1.toString() + ', ' + this.c2.toString() + ', ' + this.c3.toString() + ')';
    }

    @:native("::math::float4x4")
    extern public static function make():Single4x4 ;

    @:native("::math::float4x4::operator*")
    extern public function mulMat( b : Single4x4Data):Single4x4Data;
    
}


@:forward
@:forwardStatics
@:notNull
@:unreflective
abstract Single4x4 (Single4x4Data) to Single4x4Data from Single4x4Data {

    @:functionCode("return ::math::float4x4(0.0f);")
    public static function zero():Single4x4 {
        return Single4x4Data.make();
    }

    @:functionCode("return ::math::float4x4(1.0f);")
    public static function one():Single4x4 {
        return Single4x4Data.make();
    }

    @:op(A * B)
    public static inline function multiplyMat(a:Single4x4,b:Single4x4):Single4x4 {
        return a.mulMat(b);
    }

}


#else

typedef Single4x4Data = hvector.Vec3Data;
typedef Single3S = hvector.Vec3;

#end


// class Single4x4DataWrapper
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
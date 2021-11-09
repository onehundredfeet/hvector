package hvector;



#if hl
abstract Float2Array(hl.NativeArray<Float>)  from hl.NativeArray<Float> to hl.NativeArray<Float>  {


    public function new( x : hl.NativeArray<Float> ) {
        this = x;
    }

    public var length(get, never):Int;

	extern inline function get_length():Int {
		return this.length;
	}

    @:arrayAccess inline function getv(k:Int) : Float2{
        return new Float2( this[k * 2], this[k * 2 + 1]);
      }
    
      @:arrayAccess inline function setv(k:Int, v : Float2) {
        this[k*2] = v.x;
        this[k*2+1] = v.y;
      }
    
    public static function allocate(count): Float2Array {
        return new Float2Array(new hl.NativeArray<Float>(count * 2));
    }
}

#end

package hvector;
#if hl
abstract Int2Array(hl.NativeArray<Int>)  from hl.NativeArray<Int> to hl.NativeArray<Int>  {


    public function new( x : hl.NativeArray<Int> ) {
        this = x;
    }

    public var length(get, never):Int;

	extern inline function get_length():Int {
		return this.length;
	}

    @:arrayAccess inline function getv(k:Int) : Int2{
        return new Int2( this[k * 2], this[k * 2 + 1]);
      }
    
      @:arrayAccess inline function setv(k:Int, v : Int2) {
        this[k*2] = v.x;
        this[k*2+1] = v.y;
      }
    
    public static function allocate(count): Int2Array {
        return new Int2Array(new hl.NativeArray<Int>(count * 2));
    }
}

#end
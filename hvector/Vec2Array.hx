
package hvector;
#if hl
abstract Vec2Array(hl.NativeArray<Single>)  from hl.NativeArray<Single> to hl.NativeArray<Single>  {


    public function new( x : hl.NativeArray<Single> ) {
        this = x;
    }

    public var length(get, never):Int;

	extern inline function get_length():Int {
		return Std.int(this.length / 2);
	}

    @:arrayAccess inline function getv(k:Int) : Vec2{
        return new Vec2( this[k * 2], this[k * 2 + 1]);
      }
    
      @:arrayAccess inline function setv(k:Int, v : Vec2) {
        this[k*2] = v.x;
        this[k*2+1] = v.y;
      }
    
    public static function allocate(count): Vec2Array {
        return new Vec2Array(new hl.NativeArray<Single>(count * 2));
    }
}

#end
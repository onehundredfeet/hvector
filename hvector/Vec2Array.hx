
package hvector;
#if hl
abstract Vec2Array(Array<Single>)  from Array<Single> to Array<Single>  {


    public function new( x : Array<Single> ) {
        this = x;
    }

    public var length(get, never):Int;

	extern inline function get_length():Int {
		return Std.int(this.length / 2);
	}

    public function resize( count : Int ) {
        this.resize( count * 2 );
    }

    @:arrayAccess inline function getv(k:Int) : Vec2{
        return new Vec2( this[k * 2], this[k * 2 + 1]);
      }
    
      @:arrayAccess inline function setv(k:Int, v : Vec2) {
        this[k*2] = v.x;
        this[k*2+1] = v.y;
      }
    
    public static function allocate(count): Vec2Array {
        var x = new Vec2Array(new Array<Single>());
        x.resize(count);
        return x;
    }
}

#end
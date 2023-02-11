package hvector;



#if hl
abstract Float2Array(Array<Float>)  from Array<Float> to Array<Float>  {
    public function new( x : Array<Float> ) {
        this = x;
    }

    public var length(get, never):Int;

	extern inline function get_length():Int {
		return Std.int(this.length / 2);
	}

    public inline function resize( len : Int ) {
        this.resize(len * 2);
    }

    public inline function push( v : Float2 ) {
        this.push(v.x);
        this.push(v.y);
    }

    @:arrayAccess inline function getv(k:Int) : Float2{
        return new Float2( this[k * 2], this[k * 2 + 1]);
      }
    
      @:arrayAccess inline function setv(k:Int, v : Float2) {
        this[k*2] = v.x;
        this[k*2+1] = v.y;
      }
    
      public static function empty(): Float2Array {
        return new Array<Float>();
    }

    public static function allocate(count): Float2Array {
        var x = new Array<Float>();
        x.resize(count * 2);
        return new Float2Array(x);
    }
}

#end
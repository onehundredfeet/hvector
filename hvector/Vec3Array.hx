
package hvector;
#if hl
abstract Vec3Array(hl.NativeArray<Single>)  from hl.NativeArray<Single> to hl.NativeArray<Single>  {

    static inline final COMP_NUM : Int = 3;
    public function new( x : hl.NativeArray<Single> ) {
        this = x;
    }

    public var length(get, never):Int;

	extern inline function get_length():Int {
		return Std.int(this.length / COMP_NUM);
	}

    @:arrayAccess inline function getv(k:Int) : Vec3{
        return new Vec3( this[k * COMP_NUM], this[k * COMP_NUM + 1],  this[k * COMP_NUM + 2]);
      }
    
      @:arrayAccess inline function setv(k:Int, v : Vec3) {
        this[k*COMP_NUM] = v.x;
        this[k*COMP_NUM+1] = v.y;
        this[k*COMP_NUM + 2] = v.z;
      }
    
    public static function allocate(count): Vec3Array {
        return new Vec3Array(new hl.NativeArray<Single>(count * COMP_NUM));
    }
}

#end
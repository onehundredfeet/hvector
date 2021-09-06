import MathExt;

abstract AngleRadF (Float) to Float from Float{
    inline public function new(i:Float) {
        this = i;
      }

    @:from
    static public function fromString(r:Single) {
      return new AngleRadF(r);
    }
    
    @:to
    inline public function toFloat() : Float {
      return this;
    }

    inline public function radians() return this;
    inline public function degrees() return this * (180.0 / Math.PI);

    inline public function sign() return  (this >= -0.0) ? 1.0 : 0.0;
    inline public function ispositive() return  this >= -0.0;

    inline public function positive() return repeat(this, Math.PI * 2.0);
    
    @:op(A + B)
    inline public function add( rhs : AngleRadF ) return new AngleRadF( repeat( this + rhs.toFloat(), Math.PI * 2.0));

    @:op(A - B)
    inline public function sub( rhs : AngleRadF ) return new AngleRadF( repeat( this - rhs.toFloat(), Math.PI * 2.0));
    
    @:op(A * B) 
    inline function mul(b: Float): AngleRadF
      return new AngleRadF( this * b);

    inline public static function lerp( a : AngleRadF, b: AngleRadF, t : Float ) : AngleRadF
    {
      var num = bound(  b - a );
      if (num > Math.PI) {
        num -= (Math.PI * 2.0);
      }
      
      return a + num * clamp01(t);
    }
    
    inline public static function bound(x : AngleRadF ) return repeat( x, Math.PI * 2.0);
  
  
      public inline function toVector(basis : Float2,  clockwise : Bool = false) : Float2 {
          var a = (clockwise) ? -this : this;
          var cosa = Math.cos(a);
          var sina = Math.sin(a);
  
          var x1 = basis.x * cosa - basis.y * sina;
          var y1 = basis.x * sina + basis.y * cosa;
  
          return new Float2( x1, y1 );
      }
}



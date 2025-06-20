package hvector;

import hvector.MathExt;

inline function angleFromRad( x : Float ) : AngleF {
  return new AngleF(x);
}

inline function angleFromDeg( x : Float ) : AngleF {
  return new AngleF(x * Constants.DEG2RAD);
}

inline function angleAbsBetweenVectors( a : Float2, b : Float2 ) {
    return a.angleAbs(b);
}

inline function angleBetweenVectors( a : Float2, b : Float2 ) {
  return a.angle(b);
}

inline function fromUp( a : Float2 ) {
  return Float2.up().angle(a);
}

abstract AngleF (Float) to Float from Float{
    inline public function new(i:Float) {
        this = i;
      }

    @:from
    static public inline function fromSingle(r:Single) {
      return new AngleF(r);
    }
    
    static public inline function fromDeg( x : Float ) {
      return new AngleF(x * Constants.DEG2RAD);
    }
    @:to
    inline public function toFloat() : Float {
      return this;
    }

    inline public function halfAngleTan() : Float {
        return Math.tan(this * 0.5);
    }
    
    inline public function rad() : Float return this;
    inline public function deg() : Float return this * (180.0 / Constants.PI);
    inline public function magnituderad() : Float {
      var x = repeat(this, Constants.PI * 2.0);
      return ( x > Constants.PI) ? Constants.PI * 2.0 - x : x ;
    }

    inline public function relativerad() : Float {
      var x = repeat(this, Constants.PI * 2.0);
      return ( x > Constants.PI) ? x - Constants.PI * 2.0  : x ;
    }

    
    inline function rad2deg( x : Float ) {
      return x  * (180.0 / Constants.PI);
    }
    inline public function magnitudedeg() : Float {
      var x = repeat(this, Constants.PI * 2.0);
      return rad2deg(( x > Constants.PI) ? (Constants.PI * 2.) - x : x );
    }

    inline public function direction() : Float {
      var x = repeat(this, Constants.PI * 2.0);
      return ( x > Constants.PI) ? -1. : 1. ;
    }

    inline public function sign() return  (this >= -0.0) ? 1.0 : 0.0;
    inline public function ispositive() return  this >= -0.0;

    inline public function positive() return repeat(this, Constants.PI * 2.0);
    
    @:op(A + B)
    inline public function add( rhs : AngleF ) return new AngleF( repeat( this + rhs.toFloat(), Constants.PI * 2.0));

    @:op(A - B)
    inline public function sub( rhs : AngleF ) return new AngleF( repeat( this - rhs.toFloat(), Constants.PI * 2.0));
    
    @:op(A * B) 
    inline function mul(b: Float): AngleF
      return new AngleF( this * b);

    inline public static function lerp( a : AngleF, b: AngleF, t : Float ) : AngleF
    {
      var num = bound(  b - a );
      if (num > Constants.PI) {
        num -= (Constants.PI * 2.0);
      }
      
      return a + num * clamp01(t);
    }
    
    inline public static function bound(x : AngleF ) return repeat( x, Constants.PI * 2.0);
  
  
      public inline function toVector(basis : Float2,  clockwise : Bool = false) : Float2 {
          var a = (clockwise) ? -this : this;
          var cosa = Math.cos(a);
          var sina = Math.sin(a);
  
          var x1 = basis.x * cosa - basis.y * sina;
          var y1 = basis.x * sina + basis.y * cosa;
  
          return new Float2( x1, y1 );
      }

      public inline function toVectorRight(clockwise : Bool = false) : Float2 {
        return toVector(Float2.right(), clockwise);
    }
}



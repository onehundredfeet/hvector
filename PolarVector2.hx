import Float2;

abstract PolarVector2F(Float2)
{
    public inline function new (angle : AngleF,  mag : Float)
    {
        this = new Float2( angle, mag );
    }

    public inline function set_angle( angle:AngleF ) {
        this.x = angle;
    }
    public inline function set_magnitude( mag:Float ) {
        this.y = mag;
    }

    public static inline function fromVector( basis : Float2, b : Float2,  clockwise : Bool = false ) : PolarVector2F
    {
        var magnitude = b.length();
        if (magnitude <= 0.00001)
        {
            return new PolarVector2F(0.0, 0.0);
        }
        var unit = b / magnitude;

        if (clockwise) {
            return new PolarVector2F(basis.angle( unit, clockwise),magnitude);
        }
        return new PolarVector2F(basis.angle( unit, clockwise),magnitude);

    }

    public inline function toVectorUp(clockwise : Bool = false) : Float2 {
        return angle().toVector( Float2.up(), clockwise ) * this.y;
    }

    public inline function toVector(basis : Float2 ,  clockwise : Bool = false) : Float2 {
        return angle().toVector( basis, clockwise ) * this.y;
    }

    @:op(a * b) @:commutative
	static inline function mulScalar(a: PolarVector2F, b: Float): PolarVector2F
		return new PolarVector2F( a.angle(), a.magnitude() * b);

    public inline function angle() : AngleF return this.x;
    public inline function magnitude() return this.y;
}


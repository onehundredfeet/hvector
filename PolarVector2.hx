import Float2;

abstract PolarVector2F(Float2)
{
//    var _angle : AngleRad;
  //  var _magnitude : Float;

    public inline function new (angle : AngleRadF,  mag : Float)
    {
        this = new Float2( angle, mag );
    }

    public inline function set_angle( angle:AngleRadF ) {
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

    public inline function toVector(basis : Float2,  clockwise : Bool = false) : Vec2 {
        var a = (clockwise) ? -this.x : this.x;
        var cosa = Math.cos(a);
        var sina = Math.sin(a);

        var x1 = basis.x * cosa - basis.y * sina;
        var y1 = basis.x * sina + basis.y * cosa;

        return new Vec2( x1 * this.y, y1 * this.y);
    }

    @:op(a * b) @:commutative
	static inline function mulScalar(a: PolarVector2F, b: Float): PolarVector2F
		return new PolarVector2F( a.angle(), a.magnitude() * b);

    public inline function angle() return this.x;
    public inline function magnitude() return this.y;
}
/*
    public inline function tounitvector() : Vec2 {
        
    }


    public float Angle
    {
        get => _angle;
        set
        {
            _angle = value;
            _unit = _angle.AsUnitRotation();
            _vector = _unit * _magnitude;
        }
    }

    public float Magnitude
    {
        get => _magnitude;
        set
        {
            _magnitude = value;
            _vector = _unit * _magnitude;
        }
    }

    public (float, float) Polar
    {
        get { return (_angle, _magnitude); }
        set
        {
            (_angle, _magnitude) = value;
            _unit = _angle.AsUnitRotation();
            _vector = _unit * _magnitude;
        }
    }

    //public static implicit operator PolarVector2(Vector2f v) => new PolarVector2(v);
    //public static implicit operator Vector2f(PolarVector2 v) => v.Vector;
    
    private Vector2f _vector;
    private Vector2f _unit;
    private float _angle;
    private float _magnitude;
}
}*/

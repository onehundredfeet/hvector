package hvector;


abstract PolarVector2F(Float2) {
	public static inline function zero() {
		return new PolarVector2F(0., 0.);
	}

	public inline function new(angle:AngleF, mag:Float) {
		this = new Float2(angle, mag);
	}

	public var angle(get, set):AngleF;
	public var magnitude(get, set):Float;

	@:op(A - B)
	public inline function minus(rhs : PolarVector2F) : PolarVector2F {
		return new PolarVector2F( angle - rhs.angle, magnitude - rhs.magnitude);
	}

	public inline function set_angle(angle:AngleF) {
		this.x = angle;
		return angle;
	}

	public inline function get_angle():AngleF {
		return this.x;
	}

	public inline function set_magnitude(mag:Float) {
		this.y = mag;
		return mag;
	}

	public inline function get_magnitude():Float
		return this.y;

	public inline function toVectorUp(clockwise:Bool = false):Float2 {
		return angle.toVector(Float2.up(), clockwise) * this.y;
	}

	public inline function toVector(basis:Float2, clockwise:Bool = false):Float2 {
		return angle.toVector(basis, clockwise) * this.y;
	}

	@:op(A - B)
	inline function sub( rhs:PolarVector2F):PolarVector2F
		return new PolarVector2F(angle - rhs.angle, magnitude - rhs.magnitude);
}

inline function scale(a:PolarVector2F, b:Float):PolarVector2F
	return new PolarVector2F(a.angle, a.magnitude * b);

inline function mul(a:PolarVector2F, b:Float):PolarVector2F
	return new PolarVector2F(a.angle * b, a.magnitude * b);

inline function add(a:PolarVector2F, b:PolarVector2F):PolarVector2F
	return new PolarVector2F(a.angle + b.angle, a.magnitude * b.magnitude);




inline function polarFromVectorOrDefault(basis:Float2, v:Float2, d:PolarVector2F, clockwise:Bool = false):PolarVector2F {
	var magnitude = v.length();
	if (magnitude <= 0.00001) {
		return d;
	}
	var unit = v / magnitude;

	if (clockwise) {
		return new PolarVector2F(basis.angle(unit, clockwise), magnitude);
	}
	return new PolarVector2F(basis.angle(unit, clockwise), magnitude);
}

inline function polarFromVector(basis:Float2, v:Float2, clockwise:Bool = false):PolarVector2F {
	var magnitude = v.length();
	if (magnitude <= 0.00001) {
		return new PolarVector2F(0.0, 0.0);
	}
	var unit = v / magnitude;

	if (clockwise) {
		return new PolarVector2F(basis.angle(unit, clockwise), magnitude);
	}
	return new PolarVector2F(basis.angle(unit, clockwise), magnitude);
}

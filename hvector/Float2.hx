package hvector;
import hvector.MathExt;

#if macro
import hvector.macro.SwizzleF;
#end
#if (vector_math_f32 && (cpp || hl || cs || java))
// override Float (usually f64) type with f32
//@:eager private typedef Float = Single;
#end


@:nullSafety
abstract Float2(Float2Data) to Float2Data from Float2Data {
	#if !macro
	public inline function new(x: Float, y: Float) {
		this = new Float2Data(x, y);
	}

	// I have this sneaking suspicion the compiler will NOT inline these
	// it's really more than a suspicion
	public static inline function up() : Float2 return new Float2(0.0, 1.0); 
	public static inline function down() : Float2 return new Float2(0.0, -1.0); 
	public static inline function left() : Float2 return new Float2(-1.0, 0.0); 
	public static inline function right() : Float2 return new Float2(1.0, 0.0); 
	public static inline function one() : Float2 return new Float2(1.0, 1.0); 
	public static inline function zero() : Float2 return new Float2(0.0, 0.0); 
	public static inline function positiveInfinity(): Float2  return new Float2(Math.POSITIVE_INFINITY, Math.POSITIVE_INFINITY); 
	public static inline function negativeInfinity(): Float2  return new Float2(Math.NEGATIVE_INFINITY, Math.NEGATIVE_INFINITY); 
	public static inline function fromArray(a : Array<Float>, x = 0, y = 1): Float2  return new Float2(a[x], a[y]); 
	public inline function asArray() : Array<Float>  return [x, y];
	public static inline function fromAngle( a : AngleF ): Float2  return a.toVectorRight();

	public var x (get, set): Float;
	inline function get_x() return this.x;
	inline function set_x(v: Float) return this.x = v;
	public var y (get, set): Float;
	inline function get_y() return this.y;
	inline function set_y(v: Float) return this.y = v;


	public inline function copyFrom(v: Float2) {
		x = v.x;
		y = v.y;
		return this;
	}

	public inline function clone() {
		return new Float2(x, y);
	}

	// Trigonometric
	public inline function radians(): Float2 {
		return (this: Float2) * Constants.PI / 180;
	}
	public inline function degrees(): Float2 {
		return (this: Float2) * 180 / Constants.PI;
	}
	public inline function sin(): Float2 {
		return new Float2(
			Math.sin(x),
			Math.sin(y)
		);
	}
	public inline function cos(): Float2 {
		return new Float2(
			Math.cos(x),
			Math.cos(y)
		);
	}
	public inline function tan(): Float2 {
		return new Float2(
			Math.tan(x),
			Math.tan(y)
		);
	}
	public inline function asin(): Float2 {
		return new Float2(
			Math.asin(x),
			Math.asin(y)
		);
	}
	public inline function acos(): Float2 {
		return new Float2(
			Math.acos(x),
			Math.acos(y)
		);
	}
	public inline function atan(): Float2 {
		return new Float2(
			Math.atan(x),
			Math.atan(y)
		);
	}
	public inline function atan2(b: Float2): Float2 {
		return new Float2(
			Math.atan2(x, b.x),
			Math.atan2(y, b.y)
		);
	}

	// Exponential
	public inline function pow(e: Float2): Float2 {
		return new Float2(
			Math.pow(x, e.x),
			Math.pow(y, e.y)
		);
	}
	public inline function exp(): Float2 {
		return new Float2(
			Math.exp(x),
			Math.exp(y)
		);
	}
	public inline function log(): Float2 {
		return new Float2(
			Math.log(x),
			Math.log(y)
		);
	}
	public inline function exp2(): Float2 {
		return new Float2(
			Math.pow(2, x),
			Math.pow(2, y)
		);
	}
	public inline function log2(): Float2 @:privateAccess {
		return new Float2(
			ShaderMath.log2f(x),
			ShaderMath.log2f(y)
		);
	}
	public inline function sqrt(): Float2 {
		return new Float2(
			Math.sqrt(x),
			Math.sqrt(y)
		);
	}
	public inline function inverseSqrt(): Float2 {
		return 1.0 / sqrt();
	}

	// Common
	public inline function abs(): Float2 {
		return new Float2(
			Math.abs(x),
			Math.abs(y)
		);
	}
	public inline function sign(): Float2 {
		return new Float2(
			x > 0. ? 1. : (x < 0. ? -1. : 0.),
			y > 0. ? 1. : (y < 0. ? -1. : 0.)
		);
	}
	public inline function floor(): Float2 {
		return new Float2(
			Math.floor(x),
			Math.floor(y)
		);
	}
	public inline function ceil(): Float2 {
		return new Float2(
			Math.ceil(x),
			Math.ceil(y)
		);
	}

//	public static float SignedAngle(this Vector2f from, Vector2f to) => 
	
//	Vector2Ext.Angle(from, to) * MathF.Sign((float) ((double) from.X * (double) to.Y - (double) from.Y * (double) to.X));

	public inline function angleAbs( b : Float2) : AngleF
    {
        var num = Math.sqrt( lengthSquared() * b.lengthSquared());

		var x = dot( b ) / num;
		var y = MathExt.clamp(x, -1., 1.);

        return (num < 1.0000000036274937E-15) ? 0.0 : Math.acos( y );
    }


	public inline function perpendicular(clockwise : Bool = true ) : Float2 {
		if (clockwise) 
			return new Float2(y, -x);
		return new Float2(y, x);
	}
	public inline function angle( b : Float2, clockwise : Bool = false) : AngleF {
		var dir = dot(b.perpendicular(clockwise));
		var a = angleAbs(b);

		var invert = dir < -0.0 ? -1.0 : 1.0;

		return (a * invert).positive();
	}

	public inline function fract(): Float2 {
		return (this: Float2) - floor();
	}
	public extern overload inline function mod(d: Float2): Float2 {
		return (this: Float2) - d * ((this: Float2) / d).floor();
	}
	public extern overload inline function mod(d: Float): Float2 {
		return (this: Float2) - d * ((this: Float2) / d).floor();
	}
	public extern overload inline function min(b: Float2): Float2 {
		return new Float2(
			b.x < x ? b.x : x,
			b.y < y ? b.y : y
		);
	}
	public extern overload inline function min(b: Float): Float2 {
		return new Float2(
			b < x ? b : x,
			b < y ? b : y
		);
	}
	public extern overload inline function max(b: Float2): Float2 {
		return new Float2(
			x < b.x ? b.x : x,
			y < b.y ? b.y : y
		);
	}
	public extern overload inline function max(b: Float): Float2 {
		return new Float2(
			x < b ? b : x,
			y < b ? b : y
		);
	}
	public extern overload inline function clamp(minLimit: Float2, maxLimit: Float2) {
		return max(minLimit).min(maxLimit);
	}
	public extern overload inline function clamp(minLimit: Float, maxLimit: Float) {
		return max(minLimit).min(maxLimit);
	}

	public extern overload inline function mix(b: Float2, t: Float2): Float2 {
		return (this: Float2) * (1.0 - t) + b * t;
	}
	public extern overload inline function mix(b: Float2, t: Float): Float2 {
		return (this: Float2) * (1.0 - t) + b * t;
	}

	public extern overload inline function step(edge: Float2): Float2 {
		return new Float2(
			x < edge.x ? 0.0 : 1.0,
			y < edge.y ? 0.0 : 1.0
		);
	}
	public extern overload inline function step(edge: Float): Float2 {
		return new Float2(
			x < edge ? 0.0 : 1.0,
			y < edge ? 0.0 : 1.0
		);
	}

	public extern overload inline function smoothstep(edge0: Float2, edge1: Float2): Float2 {
		var t = (((this: Float2) - edge0) / (edge1 - edge0)).clamp(0, 1);
		return t * t * (3.0 - 2.0 * t);
	}
	public extern overload inline function smoothstep(edge0: Float, edge1: Float): Float2 {
		var t = (((this: Float2) - edge0) / (edge1 - edge0)).clamp(0, 1);
		return t * t * (3.0 - 2.0 * t);
	}

	// Geometric
	public inline function length(): Float {
		return Math.sqrt(x*x + y*y);
	}	
	public inline function lengthSquared(): Float {
		return x*x + y*y;
	}
	public inline function distance(b: Float2): Float {
		return (b - this).length();
	}
	public inline function dot(b: Float2): Float {
		return x * b.x + y * b.y;
	}
	public inline function cross(b: Float2): Float {
		return x * b.y - y * b.x;
	}

	public inline function normalized(): Float2 {
		var v: Float2 = this;
		var lenSq = v.dot(this);
		var denominator = lenSq == 0.0 ? 1.0 : Math.sqrt(lenSq); // for 0 length, return zero vector rather than infinity
		return v / denominator;
	}

	public inline function faceforward(I: Float2, Nref: Float2): Float2 {
		return new Float2(x, y) * (Nref.dot(I) < 0 ? 1 : -1);
	}
	public inline function reflect(N: Float2): Float2 {
		var I = (this: Float2);
		return I - 2 * N.dot(I) * N;
	}
	public inline function refract(N: Float2, eta: Float): Float2 {
		var I = (this: Float2);
		var nDotI = N.dot(I);
		var k = 1.0 - eta * eta * (1.0 - nDotI * nDotI);
		return
			(eta * I - (eta * nDotI + Math.sqrt(k)) * N)
			* (k < 0.0 ? 0.0 : 1.0); // if k < 0, result should be 0 vector
	}

	public inline function toString() {
		return 'Float2(${x}, ${y})';
	}

	@:op([])
	inline function arrayRead(i: Int)
		return switch i {
			case 0: x;
			case 1: y;
			default: null;
		}

	@:op([])
	inline function arrayWrite(i: Int, v: Float)
		return switch i {
			case 0: x = v;
			case 1: y = v;
			default: null;
		}

	@:op(-a)
	static inline function neg(a: Float2)
		return new Float2(-a.x, -a.y);

	@:op(++a)
	static inline function prefixIncrement(a: Float2) {
		++a.x; ++a.y;
		return a.clone();
	}

	@:op(--a)
	static inline function prefixDecrement(a: Float2) {
		--a.x; --a.y;
		return a.clone();
	}

	@:op(a++)
	static inline function postfixIncrement(a: Float2) {
		var ret = a.clone();
		++a.x; ++a.y;
		return ret;
	}

	@:op(a--)
	static inline function postfixDecrement(a: Float2) {
		var ret = a.clone();
		--a.x; --a.y;
		return ret;
	}

	// assignment overload should come before other binary ops to ensure they have priority
	@:op(a *= b)
	static inline function mulEq(a: Float2, b: Float2): Float2
		return a.copyFrom(a * b);

	@:op(a *= b)
	static inline function mulEqMat(a: Float2, b: Float2x2): Float2
		return a.copyFrom(a * b);

	@:op(a *= b)
	static inline function mulEqScalar(a: Float2, f: Float): Float2
		return a.copyFrom(a * f);

	@:op(a /= b)
	static inline function divEq(a: Float2, b: Float2): Float2
		return a.copyFrom(a / b);

	@:op(a /= b)
	static inline function divEqScalar(a: Float2, f: Float): Float2
		return a.copyFrom(a / f);

	@:op(a += b)
	static inline function addEq(a: Float2, b: Float2): Float2
		return a.copyFrom(a + b);

	@:op(a += b)
	static inline function addEqScalar(a: Float2, f: Float): Float2
		return a.copyFrom(a + f);

	@:op(a -= b)
	static inline function subEq(a: Float2, b: Float2): Float2
		return a.copyFrom(a - b);

	@:op(a -= b)
	static inline function subEqScalar(a: Float2, f: Float): Float2
		return a.copyFrom(a - f);

	@:op(a * b)
	static inline function mul(a: Float2, b: Float2): Float2
		return new Float2(a.x * b.x, a.y * b.y);

	@:op(a * b) @:commutative
	static inline function mulScalar(a: Float2, b: Float): Float2
		return new Float2(a.x * b, a.y * b);

	@:op(a / b)
	static inline function div(a: Float2, b: Float2): Float2
		return new Float2(a.x / b.x, a.y / b.y);

	@:op(a / b)
	static inline function divScalar(a: Float2, b: Float): Float2
		return new Float2(a.x / b, a.y / b);
	
	@:op(a / b)
	static inline function divScalarInv(a: Float, b: Float2): Float2
		return new Float2(a / b.x, a / b.y);

	@:op(a + b)
	static inline function add(a: Float2, b: Float2): Float2
		return new Float2(a.x + b.x, a.y + b.y);

	@:op(a + b) @:commutative
	static inline function addScalar(a: Float2, b: Float): Float2
		return new Float2(a.x + b, a.y + b);

	@:op(a - b)
	static inline function sub(a: Float2, b: Float2): Float2
		return new Float2(a.x - b.x, a.y - b.y);

	@:op(a - b)
	static inline function subScalar(a: Float2, b: Float): Float2
		return new Float2(a.x - b, a.y - b);

	@:op(b - a)
	static inline function subScalarInv(a: Float, b: Float2): Float2
		return new Float2(a - b.x, a - b.y);

	@:op(a == b)
	static inline function equal(a: Float2, b: Float2): Bool
		return a.x == b.x && a.y == b.y;

	@:op(a != b)
	static inline function notEqual(a: Float2, b: Float2): Bool
		return !equal(a, b);

	#end // !macro

	// macros
	@:op(a.b) macro function swizzleRead(self, name: String) {
		return SwizzleF.swizzleReadExprF(self, name);
	}

	@:op(a.b) macro function swizzleWrite(self, name: String, value) {
		return SwizzleF.swizzleWriteExprF(self, name, value);
	}

	@:overload(function<T>(arrayLike: T, index: Int): T {})
	public macro function copyIntoArray(self: haxe.macro.Expr.ExprOf<Float2>, array: haxe.macro.Expr.ExprOf<ArrayAccess<Float>>, index: haxe.macro.Expr.ExprOf<Int>) {
		return macro {
			var self = $self;
			var array = $array;
			var i: Int = $index;
			array[0 + i] = self.x;
			array[1 + i] = self.y;
			array;
		}
	}
	
}

@:noCompletion
@:struct
class Float2Data {
	#if !macro
	public var x: Float;
	public var y: Float;

	public inline function new(x: Float, y: Float) {
		// the + 0.0 helps the optimizer realize it can collapse const float operations
		this.x = x + 0.0;
		this.y = y + 0.0;
	}
	#end
}
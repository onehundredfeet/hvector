package hvector;
#if macro
import haxe.macro.Expr.ExprOf;
#end

#if (vector_math_f32 && (cpp || hl || cs || java))
// override Single (usually f64) type with f32
//@:eager private typedef Single = Single;
#end

#if macro
import hvector.macro.Swizzle;
#end
#if (js || ucpp_runtime)
import hvector.Single;
#end

@:nullSafety
abstract Vec2(Vec2Data) to Vec2Data from Vec2Data {

	#if !macro

	
	public var x (get, set): Single;
	inline function get_x() return this.x;
	inline function set_x(v: Single) return this.x = v;
	public var y (get, set): Single;
	inline function get_y() return this.y;
	inline function set_y(v: Single) return this.y = v;

	public inline function new(x: Single, y: Single) {
		this = new Vec2Data(x, y);
	}

	public static inline function up() : Vec2 return new Vec2(0.0, 1.0); 
	public static inline function down() : Vec2 return new Vec2(0.0, -1.0); 
	public static inline function left() : Vec2 return new Vec2(-1.0, 0.0); 
	public static inline function right() : Vec2 return new Vec2(1.0, 0.0); 
	public static inline function one() : Vec2 return new Vec2(1.0, 1.0); 
	public static inline function zero() : Vec2 return new Vec2(0.0, 0.0); 

	public inline function set(x: Single, y: Single) {
		this.x = x;
		this.y = y;
	}

	public inline function clone() {
		return new Vec2(x, y);
	}

	// Trigonometric
	public inline function radians(): Vec2 {
		return (this: Vec2) * Constants.PI / 180;
	}
	public inline function degrees(): Vec2 {
		return (this: Vec2) * 180 / Constants.PI;
	}
	public inline function sin(): Vec2 {
		return new Vec2(
			Math.sin(x),
			Math.sin(y)
		);
	}
	public inline function cos(): Vec2 {
		return new Vec2(
			Math.cos(x),
			Math.cos(y)
		);
	}
	public inline function tan(): Vec2 {
		return new Vec2(
			Math.tan(x),
			Math.tan(y)
		);
	}
	public inline function asin(): Vec2 {
		return new Vec2(
			Math.asin(x),
			Math.asin(y)
		);
	}
	public inline function acos(): Vec2 {
		return new Vec2(
			Math.acos(x),
			Math.acos(y)
		);
	}
	public inline function atan(): Vec2 {
		return new Vec2(
			Math.atan(x),
			Math.atan(y)
		);
	}
	public inline function atan2(b: Vec2): Vec2 {
		return new Vec2(
			Math.atan2(x, b.x),
			Math.atan2(y, b.y)
		);
	}

	// Exponential
	public inline function pow(e: Vec2): Vec2 {
		return new Vec2(
			Math.pow(x, e.x),
			Math.pow(y, e.y)
		);
	}
	public inline function exp(): Vec2 {
		return new Vec2(
			Math.exp(x),
			Math.exp(y)
		);
	}
	public inline function log(): Vec2 {
		return new Vec2(
			Math.log(x),
			Math.log(y)
		);
	}
	public inline function exp2(): Vec2 {
		return new Vec2(
			Math.pow(2, x),
			Math.pow(2, y)
		);
	}
	public inline function log2(): Vec2 @:privateAccess {
		return new Vec2(
			ShaderMath.log2f(x),
			ShaderMath.log2f(y)
		);
	}
	public inline function sqrt(): Vec2 {
		return new Vec2(
			Math.sqrt(x),
			Math.sqrt(y)
		);
	}
	public inline function inverseSqrt(): Vec2 {
		return 1.0 / sqrt();
	}

	// Common
	public inline function abs(): Vec2 {
		return new Vec2(
			Math.abs(x),
			Math.abs(y)
		);
	}
	public inline function sign(): Vec2 {
		return new Vec2(
			x > 0. ? 1. : (x < 0. ? -1. : 0.),
			y > 0. ? 1. : (y < 0. ? -1. : 0.)
		);
	}
	public inline function floor(): Vec2 {
		return new Vec2(
			Math.floor(x),
			Math.floor(y)
		);
	}
	public inline function ceil(): Vec2 {
		return new Vec2(
			Math.ceil(x),
			Math.ceil(y)
		);
	}
	public inline function fract(): Vec2 {
		return (this: Vec2) - floor();
	}
	
	public extern overload inline function mod(d: Vec2): Vec2 {
		return (this: Vec2) - d * ((this: Vec2) / d).floor();
	}
	public extern overload inline function mod(d: Single): Vec2 {
		return (this: Vec2) - d * ((this: Vec2) / d).floor();
	}
	public extern overload inline function min(b: Vec2): Vec2 {
		return new Vec2(
			b.x < x ? b.x : x,
			b.y < y ? b.y : y
		);
	}
	public extern overload inline function min(b: Single): Vec2 {
		return new Vec2(
			b < x ? b : x,
			b < y ? b : y
		);
	}
	public extern overload inline function max(b: Vec2): Vec2 {
		return new Vec2(
			x < b.x ? b.x : x,
			y < b.y ? b.y : y
		);
	}
	public extern overload inline function max(b: Single): Vec2 {
		return new Vec2(
			x < b ? b : x,
			y < b ? b : y
		);
	}
	public extern overload inline function clamp(minLimit: Vec2, maxLimit: Vec2) {
		return max(minLimit).min(maxLimit);
	}
	public extern overload inline function clamp(minLimit: Single, maxLimit: Single) {
		return max(minLimit).min(maxLimit);
	}

	public extern overload inline function mix(b: Vec2, t: Vec2): Vec2 {
		return (this: Vec2) * (1.0 - t) + b * t;
	}
	public extern overload inline function mix(b: Vec2, t: Single): Vec2 {
		return (this: Vec2) * (1.0 - t) + b * t;
	}

	public extern overload inline function step(edge: Vec2): Vec2 {
		return new Vec2(
			x < edge.x ? 0.0 : 1.0,
			y < edge.y ? 0.0 : 1.0
		);
	}
	public extern overload inline function step(edge: Single): Vec2 {
		return new Vec2(
			x < edge ? 0.0 : 1.0,
			y < edge ? 0.0 : 1.0
		);
	}

	public extern overload inline function smoothstep(edge0: Vec2, edge1: Vec2): Vec2 {
		var t = (((this: Vec2) - edge0) / (edge1 - edge0)).clamp(0, 1);
		return t * t * (3.0 - 2.0 * t);
	}
	public extern overload inline function smoothstep(edge0: Single, edge1: Single): Vec2 {
		var t = (((this: Vec2) - edge0) / (edge1 - edge0)).clamp(0, 1);
		return t * t * (3.0 - 2.0 * t);
	}

	
	// Geometric
	public inline function length(): Single {
		return Math.sqrt(x*x + y*y);
	}
	public inline function lengthSquared(): Float {
		return x*x + y*y;
	}	
	public inline function distance(b: Vec2): Single {
		return (b - this).length();
	}
	public inline function dot(b: Vec2): Single {
		return x * b.x + y * b.y;
	}
	public inline function projectOnto(a: Vec2): Vec2 {
		return dot(a) / a.dot(a) * a;
	}
	public inline function project(a: Vec2): Vec2 {
		var v: Vec2 = this;
		return v * (dot(a) / dot(this));
	}
	public inline function normalize(): Vec2 {
		var v: Vec2 = this;
		var lenSq = v.dot(this);
		var denominator = lenSq == 0.0 ? 1.0 : Math.sqrt(lenSq); // for 0 length, return zero vector rather than infinity
		return v / denominator;
	}
	public inline function faceforward(I: Vec2, Nref: Vec2): Vec2 {
		return new Vec2(x, y) * (Nref.dot(I) < 0 ? 1 : -1);
	}
	public inline function reflect(N: Vec2): Vec2 {
		var I = (this: Vec2);
		return I - 2 * N.dot(I) * N;
	}
	public inline function refract(N: Vec2, eta: Single): Vec2 {
		var I = (this: Vec2);
		var nDotI = N.dot(I);
		var k = 1.0 - eta * eta * (1.0 - nDotI * nDotI);
		return
			(eta * I - (eta * nDotI + Math.sqrt(k)) * N)
			* (k < 0.0 ? 0.0 : 1.0); // if k < 0, result should be 0 vector
	}
	public inline function perpendicular(clockwise : Bool = true ) : Vec2 {
		if (clockwise) 
			return new Vec2(y, -x);
		return new Vec2(y, x);
	}
	public inline function angleAbs( b : Vec2) : AngleF {
		var num = Math.sqrt( lengthSquared() * b.lengthSquared());

		var x = dot( b ) / num;
		var y = MathExt.clamp(x, -1., 1.);

		return (num < 1.0000000036274937E-15) ? 0.0 : Math.acos( y );
	}
	
	public inline function angle( b : Vec2, clockwise : Bool = false) : AngleF {
		var dir = dot(b.perpendicular(clockwise));
		var a = angleAbs(b);

		var invert = dir < -0.0 ? -1.0 : 1.0;

		return (a * invert).positive();
	}
	
	
	public inline function toString() {
		return 'Vec2(${x}, ${y})';
	}

	@:op([])
	inline function arrayRead(i: Int)
		return switch i {
			case 0: x;
			case 1: y;
			default: null;
		}

	@:op([])
	inline function arrayWrite(i: Int, v: Single)
		return switch i {
			case 0: x = v;
			case 1: y = v;
			default: null;
		}

	@:op(-a)
	static inline function neg(a: Vec2)
		return new Vec2(-a.x, -a.y);

	@:op(++a)
	static inline function prefixIncrement(a: Vec2) {
		++a.x; ++a.y;
		return a.clone();
	}

	@:op(--a)
	static inline function prefixDecrement(a: Vec2) {
		--a.x; --a.y;
		return a.clone();
	}

	@:op(a++)
	static inline function postfixIncrement(a: Vec2) {
		var ret = a.clone();
		++a.x; ++a.y;
		return ret;
	}

	@:op(a--)
	static inline function postfixDecrement(a: Vec2) {
		var ret = a.clone();
		--a.x; --a.y;
		return ret;
	}

	// assignment overload should come before other binary ops to ensure they have priority
	@:op(a *= b)
	static inline function mulEq(a: Vec2, b: Vec2): Vec2
		return a.copyFrom(a * b);

	@:op(a *= b)
	static inline function mulEqMat(a: Vec2, b: Mat2): Vec2
		return a.copyFrom(a * b);

	@:op(a *= b)
	static inline function mulEqScalar(a: Vec2, f: Single): Vec2
		return a.copyFrom(a * f);

	@:op(a /= b)
	static inline function divEq(a: Vec2, b: Vec2): Vec2
		return a.copyFrom(a / b);

	@:op(a /= b)
	static inline function divEqScalar(a: Vec2, f: Single): Vec2
		return a.copyFrom(a / f);

	@:op(a += b)
	static inline function addEq(a: Vec2, b: Vec2): Vec2
		return a.copyFrom(a + b);

	@:op(a += b)
	static inline function addEqScalar(a: Vec2, f: Single): Vec2
		return a.copyFrom(a + f);

	@:op(a -= b)
	static inline function subEq(a: Vec2, b: Vec2): Vec2
		return a.copyFrom(a - b);

	@:op(a -= b)
	static inline function subEqScalar(a: Vec2, f: Single): Vec2
		return a.copyFrom(a - f);

	@:op(a * b)
	static inline function mul(a: Vec2, b: Vec2): Vec2
		return new Vec2(a.x * b.x, a.y * b.y);

	@:op(a * b) @:commutative
	static inline function mulScalar(a: Vec2, b: Single): Vec2
		return new Vec2(a.x * b, a.y * b);

	@:op(a / b)
	static inline function div(a: Vec2, b: Vec2): Vec2
		return new Vec2(a.x / b.x, a.y / b.y);

	@:op(a / b)
	static inline function divScalar(a: Vec2, b: Single): Vec2
		return new Vec2(a.x / b, a.y / b);
	
	@:op(a / b)
	static inline function divScalarInv(a: Single, b: Vec2): Vec2
		return new Vec2(a / b.x, a / b.y);

	@:op(a + b)
	static inline function add(a: Vec2, b: Vec2): Vec2
		return new Vec2(a.x + b.x, a.y + b.y);

	@:op(a + b) @:commutative
	static inline function addScalar(a: Vec2, b: Single): Vec2
		return new Vec2(a.x + b, a.y + b);

	@:op(a - b)
	static inline function sub(a: Vec2, b: Vec2): Vec2
		return new Vec2(a.x - b.x, a.y - b.y);

	@:op(a - b)
	static inline function subScalar(a: Vec2, b: Single): Vec2
		return new Vec2(a.x - b, a.y - b);

	@:op(b - a)
	static inline function subScalarInv(a: Single, b: Vec2): Vec2
		return new Vec2(a - b.x, a - b.y);

	@:op(a == b)
	static inline function equal(a: Vec2, b: Vec2): Bool
		return a.x == b.x && a.y == b.y;

	@:op(a != b)
	static inline function notEqual(a: Vec2, b: Vec2): Bool
		return !equal(a, b);

	#end // !macro

	// macros
	@:op(a.b) macro function swizzleRead(self, name: String) {
		return Swizzle.swizzleReadExpr(self, name);
	}

	@:op(a.b) macro function swizzleWrite(self, name: String, value) {
		return Swizzle.swizzleWriteExpr(self, name,  value);
	}

	/**
	 * Copy from any object with .x .y fields
	 */
	@:overload(function(source: {x: Float, y: Float}): Vec2 {})
	public macro function copyFrom(self: ExprOf<Vec2>, source: ExprOf<{x: Float, y: Float}>): ExprOf<Vec2> {
		return macro {
			var self = $self;
			var source = $source;
			self.x = source.x;
			self.y = source.y;
			self;
		}
	}

	/**
	 * Copy into any object with .x .y fields
	 */
	@:overload(function(target: {x: Float, y: Float}): {x: Float, y: Float} {})
	public macro function copyInto(self: ExprOf<Vec2>, target: ExprOf<{x: Float, y: Float}>): ExprOf<{x: Single, y: Single}> {
		return macro {
			var self = $self;
			var target = $target;
			target.x = self.x;
			target.y = self.y;
			target;
		}
	}

	@:overload(function<T>(arrayLike: T, index: Int): T {})
	public macro function copyIntoArray(self: ExprOf<Vec2>, array: ExprOf<ArrayAccess<Single>>, index: ExprOf<Int>) {
		return macro {
			var self = $self;
			var array = $array;
			var i: Int = $index;
			array[0 + i] = self.x;
			array[1 + i] = self.y;
			array;
		}
	}

	@:overload(function<T>(arrayLike: T, index: Int): T {})
	public macro function copyFromArray(self: ExprOf<Vec2>, array: ExprOf<ArrayAccess<Single>>, index: ExprOf<Int>) {
		return macro {
			var self = $self;
			var array = $array;
			var i: Int = $index;
			self.x = array[0 + i];
			self.y = array[1 + i];
			self;
		}
	}

	// static macros

	/**
	 * Create from any object with .x .y fields
	 */
	@:overload(function(source: {x: Float, y: Float}): Vec2 {})
	public static macro function from(xy: ExprOf<{x: Float, y: Float}>): ExprOf<Vec2> {
		return macro {
			var source = $xy;
			new Vec2(source.x, source.y);
		}
	}

	@:overload(function<T>(arrayLike: T, index: Int): T {})
	public static macro function fromArray(array: ExprOf<ArrayAccess<Float>>, index: ExprOf<Int>): ExprOf<Vec2> {
		return macro {
			var array = $array;
			var i: Int = $index;
			new Vec2(
				array[0 + i],
				array[1 + i]
			);
		}
	}
	
}

@:noCompletion
@:struct
class Vec2Data {
	#if !macro
	public var x: Single;
	public var y: Single;

	public inline function new(x: Single, y: Single) {
		// the + 0.0 helps the optimizer realize it can collapse const Single operations
		this.x = x + 0.0;
		this.y = y + 0.0;
	}
	#end
}
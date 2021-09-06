#if (vector_math_f32 && (cpp || hl || cs || java))
// override Float (usually f64) type with f32
//@:eager private typedef Float = Single;
#end

@:nullSafety
abstract Float4(Float4Data) to Float4Data from Float4Data {

	#if !macro

	public var x (get, set): Float;
	inline function get_x() return this.x;
	inline function set_x(v: Float) return this.x = v;
	public var y (get, set): Float;
	inline function get_y() return this.y;
	inline function set_y(v: Float) return this.y = v;
	public var z (get, set): Float;
	inline function get_z() return this.z;
	inline function set_z(v: Float) return this.z = v;
	public var w (get, set): Float;
	inline function get_w() return this.w;
	inline function set_w(v: Float) return this.w = v;

	public inline function new(x: Float, y: Float, z: Float, w: Float) {
		this = new Float4Data(x, y, z, w);
	}

	public inline function copyFrom(v: Float4) {
		x = v.x;
		y = v.y;
		z = v.z;
		w = v.w;
		return this;
	}

	public inline function clone() {
		return new Float4(x, y, z, w);
	}

	// Trigonometric
	public inline function radians(): Float4 {
		return (this: Float4) * Math.PI / 180;
	}
	public inline function degrees(): Float4 {
		return (this: Float4) * 180 / Math.PI;
	}
	public inline function sin(): Float4 {
		return new Float4(
			Math.sin(x),
			Math.sin(y),
			Math.sin(z),
			Math.sin(w)
		);
	}
	public inline function cos(): Float4 {
		return new Float4(
			Math.cos(x),
			Math.cos(y),
			Math.cos(z),
			Math.cos(w)
		);
	}
	public inline function tan(): Float4 {
		return new Float4(
			Math.tan(x),
			Math.tan(y),
			Math.tan(z),
			Math.tan(w)
		);
	}
	public inline function asin(): Float4 {
		return new Float4(
			Math.asin(x),
			Math.asin(y),
			Math.asin(z),
			Math.asin(w)
		);
	}
	public inline function acos(): Float4 {
		return new Float4(
			Math.acos(x),
			Math.acos(y),
			Math.acos(z),
			Math.acos(w)
		);
	}
	public inline function atan(): Float4 {
		return new Float4(
			Math.atan(x),
			Math.atan(y),
			Math.atan(z),
			Math.atan(w)
		);
	}
	public inline function atan2(b: Float4): Float4 {
		return new Float4(
			Math.atan2(x, b.x),
			Math.atan2(y, b.y),
			Math.atan2(z, b.z),
			Math.atan2(w, b.w)
		);
	}

	// Exponential
	public inline function pow(e: Float4): Float4 {
		return new Float4(
			Math.pow(x, e.x),
			Math.pow(y, e.y),
			Math.pow(z, e.z),
			Math.pow(w, e.w)
		);
	}
	public inline function exp(): Float4 {
		return new Float4(
			Math.exp(x),
			Math.exp(y),
			Math.exp(z),
			Math.exp(w)
		);
	}
	public inline function log(): Float4 {
		return new Float4(
			Math.log(x),
			Math.log(y),
			Math.log(z),
			Math.log(w)
		);
	}
	public inline function exp2(): Float4 {
		return new Float4(
			Math.pow(2, x),
			Math.pow(2, y),
			Math.pow(2, z),
			Math.pow(2, w)
		);
	}
	public inline function log2(): Float4 @:privateAccess {
		return new Float4(
			ShaderMath.log2f(x),
			ShaderMath.log2f(y),
			ShaderMath.log2f(z),
			ShaderMath.log2f(w)
		);
	}
	public inline function sqrt(): Float4 {
		return new Float4(
			Math.sqrt(x),
			Math.sqrt(y),
			Math.sqrt(z),
			Math.sqrt(w)
		);
	}
	public inline function inverseSqrt(): Float4 {
		return 1.0 / sqrt();
	}

	// Common
	public inline function abs(): Float4 {
		return new Float4(
			Math.abs(x),
			Math.abs(y),
			Math.abs(z),
			Math.abs(w)
		);
	}
	public inline function sign(): Float4 {
		return new Float4(
			x > 0. ? 1. : (x < 0. ? -1. : 0.),
			y > 0. ? 1. : (y < 0. ? -1. : 0.),
			z > 0. ? 1. : (z < 0. ? -1. : 0.),
			w > 0. ? 1. : (w < 0. ? -1. : 0.)
		);
	}
	public inline function floor(): Float4 {
		return new Float4(
			Math.floor(x),
			Math.floor(y),
			Math.floor(z),
			Math.floor(w)
		);
	}
	public inline function ceil(): Float4 {
		return new Float4(
			Math.ceil(x),
			Math.ceil(y),
			Math.ceil(z),
			Math.ceil(w)
		);
	}
	public inline function fract(): Float4 {
		return (this: Float4) - floor();
	}
	public extern overload inline function mod(d: Float): Float4 {
		return (this: Float4) - d * ((this: Float4) / d).floor();
	}
	public extern overload inline function mod(d: Float4): Float4 {
		return (this: Float4) - d * ((this: Float4) / d).floor();
	}
	public extern overload inline function min(b: Float4): Float4 {
		return new Float4(
			b.x < x ? b.x : x,
			b.y < y ? b.y : y,
			b.z < z ? b.z : z,
			b.w < w ? b.w : w
		);
	}
	public extern overload inline function min(b: Float): Float4 {
		return new Float4(
			b < x ? b : x,
			b < y ? b : y,
			b < z ? b : z,
			b < w ? b : w
		);
	}
	public extern overload inline function max(b: Float4): Float4 {
		return new Float4(
			x < b.x ? b.x : x,
			y < b.y ? b.y : y,
			z < b.z ? b.z : z,
			w < b.w ? b.w : w
		);
	}
	public extern overload inline function max(b: Float): Float4 {
		return new Float4(
			x < b ? b : x,
			y < b ? b : y,
			z < b ? b : z,
			w < b ? b : w
		);
	}
	public extern overload inline function clamp(minLimit: Float4, maxLimit: Float4) {
		return max(minLimit).min(maxLimit);
	}
	public extern overload inline function clamp(minLimit: Float, maxLimit: Float) {
		return max(minLimit).min(maxLimit);
	}

	public extern overload inline function mix(b: Float4, t: Float4): Float4 {
		return (this: Float4) * (1.0 - t) + b * t;
	}
	public extern overload inline function mix(b: Float4, t: Float): Float4 {
		return (this: Float4) * (1.0 - t) + b * t;
	}

	public extern overload inline function step(edge: Float4): Float4 {
		return new Float4(
			x < edge.x ? 0.0 : 1.0,
			y < edge.y ? 0.0 : 1.0,
			z < edge.z ? 0.0 : 1.0,
			w < edge.w ? 0.0 : 1.0
		);
	}
	public extern overload inline function step(edge: Float): Float4 {
		return new Float4(
			x < edge ? 0.0 : 1.0,
			y < edge ? 0.0 : 1.0,
			z < edge ? 0.0 : 1.0,
			w < edge ? 0.0 : 1.0
		);
	}

	public extern overload inline function smoothstep(edge0: Float4, edge1: Float4): Float4 {
		var t = (((this: Float4) - edge0) / (edge1 - edge0)).clamp(0, 1);
		return t * t * (3.0 - 2.0 * t);
	}
	public extern overload inline function smoothstep(edge0: Float, edge1: Float): Float4 {
		var t = (((this: Float4) - edge0) / (edge1 - edge0)).clamp(0, 1);
		return t * t * (3.0 - 2.0 * t);
	}

	// Geometric
	public inline function length(): Float {
		return Math.sqrt(x*x + y*y + z*z + w*w);
	}	
	public inline function distance(b: Float4): Float {
		return (b - this).length();
	}
	public inline function dot(b: Float4): Float {
		return x * b.x + y * b.y + z * b.z + w * b.w;
	}
	public inline function normalize(): Float4 {
		var v: Float4 = this;
		var lenSq = v.dot(this);
		var denominator = lenSq == 0.0 ? 1.0 : Math.sqrt(lenSq); // for 0 length, return zero vector rather than infinity
		return v / denominator;
	}

	public inline function faceforward(I: Float4, Nref: Float4): Float4 {
		return new Float4(x, y, z, w) * (Nref.dot(I) < 0 ? 1 : -1);
	}
	public inline function reflect(N: Float4): Float4 {
		var I = (this: Float4);
		return I - 2 * N.dot(I) * N;
	}
	public inline function refract(N: Float4, eta: Float): Float4 {
		var I = (this: Float4);
		var nDotI = N.dot(I);
		var k = 1.0 - eta * eta * (1.0 - nDotI * nDotI);
		return
			(eta * I - (eta * nDotI + Math.sqrt(k)) * N)
			* (k < 0.0 ? 0.0 : 1.0); // if k < 0, result should be 0 vector
	}

	public inline function toString() {
		return 'Float4(${x}, ${y}, ${z}, ${w})';
	}

	@:op([])
	inline function arrayRead(i: Int)
		return switch i {
			case 0: x;
			case 1: y;
			case 2: z;
			case 3: w;
			default: null;
		}

	@:op([])
	inline function arrayWrite(i: Int, v: Float)
		return switch i {
			case 0: x = v;
			case 1: y = v;
			case 2: z = v;
			case 3: w = v;
			default: null;
		}

	@:op(-a)
	static inline function neg(a: Float4)
		return new Float4(-a.x, -a.y, -a.z, -a.w);

	@:op(++a)
	static inline function prefixIncrement(a: Float4) {
		++a.x; ++a.y; ++a.z; ++a.w;
		return a.clone();
	}

	@:op(--a)
	static inline function prefixDecrement(a: Float4) {
		--a.x; --a.y; --a.z; --a.w;
		return a.clone();
	}

	@:op(a++)
	static inline function postfixIncrement(a: Float4) {
		var ret = a.clone();
		++a.x; ++a.y; ++a.z; ++a.w;
		return ret;
	}

	@:op(a--)
	static inline function postfixDecrement(a: Float4) {
		var ret = a.clone();
		--a.x; --a.y; --a.z; --a.w;
		return ret;
	}

	// assignment overload should come before other binary ops to ensure they have priority
	@:op(a *= b)
	static inline function mulEq(a: Float4, b: Float4): Float4
		return a.copyFrom(a * b);

	@:op(a *= b)
	static inline function mulEqMat(a: Float4, b: Float4x4): Float4
		return a.copyFrom(a * b);

	@:op(a *= b)
	static inline function mulEqScalar(a: Float4, f: Float): Float4
		return a.copyFrom(a * f);

	@:op(a /= b)
	static inline function divEq(a: Float4, b: Float4): Float4
		return a.copyFrom(a / b);

	@:op(a /= b)
	static inline function divEqScalar(a: Float4, f: Float): Float4
		return a.copyFrom(a / f);

	@:op(a += b)
	static inline function addEq(a: Float4, b: Float4): Float4
		return a.copyFrom(a + b);

	@:op(a += b)
	static inline function addEqScalar(a: Float4, f: Float): Float4
		return a.copyFrom(a + f);

	@:op(a -= b)
	static inline function subEq(a: Float4, b: Float4): Float4
		return a.copyFrom(a - b);

	@:op(a -= b)
	static inline function subEqScalar(a: Float4, f: Float): Float4
		return a.copyFrom(a - f);

	@:op(a * b)
	static inline function mul(a: Float4, b: Float4): Float4
		return new Float4(a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w);

	@:op(a * b) @:commutative
	static inline function mulScalar(a: Float4, b: Float): Float4
		return new Float4(a.x * b, a.y * b, a.z * b, a.w * b);

	@:op(a / b)
	static inline function div(a: Float4, b: Float4): Float4
		return new Float4(a.x / b.x, a.y / b.y, a.z / b.z, a.w / b.w);

	@:op(a / b)
	static inline function divScalar(a: Float4, b: Float): Float4
		return new Float4(a.x / b, a.y / b, a.z / b, a.w / b);
	
	@:op(a / b)
	static inline function divScalarInv(a: Float, b: Float4): Float4
		return new Float4(a / b.x, a / b.y, a / b.z, a / b.w);

	@:op(a + b)
	static inline function add(a: Float4, b: Float4): Float4
		return new Float4(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w);

	@:op(a + b) @:commutative
	static inline function addScalar(a: Float4, b: Float): Float4
		return new Float4(a.x + b, a.y + b, a.z + b, a.w + b);

	@:op(a - b)
	static inline function sub(a: Float4, b: Float4): Float4
		return new Float4(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w);

	@:op(a - b)
	static inline function subScalar(a: Float4, b: Float): Float4
		return new Float4(a.x - b, a.y - b, a.z - b, a.w - b);

	@:op(b - a)
	static inline function subScalarInv(a: Float, b: Float4): Float4
		return new Float4(a - b.x, a - b.y, a - b.z, a - b.w);

	@:op(a == b)
	static inline function equal(a: Float4, b: Float4): Bool
		return a.x == b.x && a.y == b.y && a.z == b.z && a.w == b.w;

	@:op(a != b)
	static inline function notEqual(a: Float4, b: Float4): Bool
		return !equal(a, b);

	#end // !macro

	// macros
	@:op(a.b) macro function swizzleRead(self, name: String) {
		return ShaderMathF.swizzleReadExprF(self, name);
	}

	@:op(a.b) macro function swizzleWrite(self, name: String, value) {
		return ShaderMathF.swizzleWriteExprF(self, name, value);
	}

	@:overload(function<T>(arrayLike: T, index: Int): T {})
	public macro function copyIntoArray(self: haxe.macro.Expr.ExprOf<Float4>, array: haxe.macro.Expr.ExprOf<ArrayAccess<Float>>, index: haxe.macro.Expr.ExprOf<Int>) {
		return macro {
			var self = $self;
			var array = $array;
			var i: Int = $index;
			array[0 + i] = self.x;
			array[1 + i] = self.y;
			array[2 + i] = self.z;
			array[3 + i] = self.w;
			array;
		}
	}
	
}

@:noCompletion
@:struct
class Float4Data {
	#if !macro
	public var x: Float;
	public var y: Float;
	public var z: Float;
	public var w: Float;

	public inline function new(x: Float, y: Float, z: Float, w: Float) {
		// the + 0.0 helps the optimizer realize it can collapse const float operations
		this.x = x + 0.0;
		this.y = y + 0.0;
		this.z = z + 0.0;
		this.w = w + 0.0;
	}
	#end
}
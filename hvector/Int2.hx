package hvector;

#if (vector_math_f32 && (cpp || hl || cs || java))
// override Int (usually f64) type with f32
//@:eager private typedef Int = Int;
#end

#if macro
import hvector.macro.Swizzle;
#end

@:nullSafety
abstract Int2(Int2Data) to Int2Data from Int2Data {

	#if !macro

	public var x (get, set): Int;
	inline function get_x() return this.x;
	inline function set_x(v: Int) return this.x = v;
	public var y (get, set): Int;
	inline function get_y() return this.y;
	inline function set_y(v: Int) return this.y = v;

	public inline function new(x: Int, y: Int) {
		this = new Int2Data(x, y);
	}

	public inline function copyFrom(v: Int2) {
		x = v.x;
		y = v.y;
		return this;
	}

	public inline function clone() {
		return new Int2(x, y);
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
	public inline function abs(): Int2 {
		return new Int2(
			Std.int(Math.abs(x)),
			Std.int(Math.abs(y))
		);
	}
	public inline function sign(): Int2 {
		return new Int2(
			x > 0 ? 1 : (x < 0 ? -1 : 0),
			y > 0 ? 1 : (y < 0 ? -1 : 0)
		);
	}
	public inline function floor(): Int2 {
		return new Int2(
			Math.floor(x),
			Math.floor(y)
		);
	}
	public inline function ceil(): Int2 {
		return new Int2(
			Math.ceil(x),
			Math.ceil(y)
		);
	}
	public inline function fract(): Int2 {
		return (this: Int2) - floor();
	}
	public extern overload inline function mod(d: Int2): Int2 {
		return (this: Int2) - d * ((this: Int2) / d).floor();
	}
	public extern overload inline function mod(d: Int): Int2 {
		return (this: Int2) - d * ((this: Int2) / d).floor();
	}
	public extern overload inline function min(b: Int2): Int2 {
		return new Int2(
			b.x < x ? b.x : x,
			b.y < y ? b.y : y
		);
	}
	public extern overload inline function min(b: Int): Int2 {
		return new Int2(
			b < x ? b : x,
			b < y ? b : y
		);
	}
	public extern overload inline function max(b: Int2): Int2 {
		return new Int2(
			x < b.x ? b.x : x,
			y < b.y ? b.y : y
		);
	}
	public extern overload inline function max(b: Int): Int2 {
		return new Int2(
			x < b ? b : x,
			y < b ? b : y
		);
	}
	public extern overload inline function clamp(minLimit: Int2, maxLimit: Int2) {
		return max(minLimit).min(maxLimit);
	}
	public extern overload inline function clamp(minLimit: Int, maxLimit: Int) {
		return max(minLimit).min(maxLimit);
	}

	// Geometric
	public inline function length(): Float {
		return Math.sqrt(x*x + y*y);
	}	
	public inline function distance(b: Int2): Float {
		return (b - this).length();
	}
	public inline function dot(b: Int2): Int {
		return x * b.x + y * b.y;
	}
	
	public inline function toString() {
		return 'Int2(${x}, ${y})';
	}

	@:op([])
	inline function arrayRead(i: Int)
		return switch i {
			case 0: x;
			case 1: y;
			default: null;
		}

	@:op([])
	inline function arrayWrite(i: Int, v: Int)
		return switch i {
			case 0: x = v;
			case 1: y = v;
			default: null;
		}

	@:op(-a)
	static inline function neg(a: Int2)
		return new Int2(-a.x, -a.y);

	@:op(++a)
	static inline function prefixIncrement(a: Int2) {
		++a.x; ++a.y;
		return a.clone();
	}

	@:op(--a)
	static inline function prefixDecrement(a: Int2) {
		--a.x; --a.y;
		return a.clone();
	}

	@:op(a++)
	static inline function postfixIncrement(a: Int2) {
		var ret = a.clone();
		++a.x; ++a.y;
		return ret;
	}

	@:op(a--)
	static inline function postfixDecrement(a: Int2) {
		var ret = a.clone();
		--a.x; --a.y;
		return ret;
	}

	// assignment overload should come before other binary ops to ensure they have priority
	@:op(a *= b)
	static inline function mulEq(a: Int2, b: Int2): Int2
		return a.copyFrom(a * b);

	/*
	@:op(a *= b)
	static inline function mulEqMat(a: Int2, b: Mat2): Int2
		return a.copyFrom(a * b);
*/
	@:op(a *= b)
	static inline function mulEqScalar(a: Int2, f: Int): Int2
		return a.copyFrom(a * f);

	@:op(a /= b)
	static inline function divEq(a: Int2, b: Int2): Int2
		return a.copyFrom(a / b);

	@:op(a /= b)
	static inline function divEqScalar(a: Int2, f: Int): Int2
		return a.copyFrom(a / f);

	@:op(a += b)
	static inline function addEq(a: Int2, b: Int2): Int2
		return a.copyFrom(a + b);

	@:op(a += b)
	static inline function addEqScalar(a: Int2, f: Int): Int2
		return a.copyFrom(a + f);

	@:op(a -= b)
	static inline function subEq(a: Int2, b: Int2): Int2
		return a.copyFrom(a - b);

	@:op(a -= b)
	static inline function subEqScalar(a: Int2, f: Int): Int2
		return a.copyFrom(a - f);

	@:op(a * b)
	static inline function mul(a: Int2, b: Int2): Int2
		return new Int2(a.x * b.x, a.y * b.y);

	@:op(a * b) @:commutative
	static inline function mulScalar(a: Int2, b: Int): Int2
		return new Int2(a.x * b, a.y * b);

	@:op(a / b)
	static inline function div(a: Int2, b: Int2): Int2
		return new Int2(Std.int(a.x / b.x), Std.int(a.y / b.y));

	@:op(a / b)
	static inline function divScalar(a: Int2, b: Int): Int2
		return new Int2(Std.int(a.x / b), Std.int(a.y / b));
	
	@:op(a / b)
	static inline function divScalarInv(a: Int, b: Int2): Int2
		return new Int2(Std.int(a / b.x), Std.int(a / b.y));

	@:op(a + b)
	static inline function add(a: Int2, b: Int2): Int2
		return new Int2(a.x + b.x, a.y + b.y);

	@:op(a + b) @:commutative
	static inline function addScalar(a: Int2, b: Int): Int2
		return new Int2(a.x + b, a.y + b);

	@:op(a - b)
	static inline function sub(a: Int2, b: Int2): Int2
		return new Int2(a.x - b.x, a.y - b.y);

	@:op(a - b)
	static inline function subScalar(a: Int2, b: Int): Int2
		return new Int2(a.x - b, a.y - b);

	@:op(b - a)
	static inline function subScalarInv(a: Int, b: Int2): Int2
		return new Int2(a - b.x, a - b.y);

	@:op(a == b)
	static inline function equal(a: Int2, b: Int2): Bool
		return a.x == b.x && a.y == b.y;

	@:op(a != b)
	static inline function notEqual(a: Int2, b: Int2): Bool
		return !equal(a, b);

	#end // !macro

	// macros
	@:op(a.b) macro function swizzleRead(self, name: String) {
		return Swizzle.swizzleReadExpr(self, name);
	}

	@:op(a.b) macro function swizzleWrite(self, name: String, value) {
		return Swizzle.swizzleWriteExpr(self, name,  value);
	}

	@:overload(function<T>(arrayLike: T, index: Int): T {})
	public macro function copyIntoArray(self: haxe.macro.Expr.ExprOf<Int2>, array: haxe.macro.Expr.ExprOf<ArrayAccess<Int>>, index: haxe.macro.Expr.ExprOf<Int>) {
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
class Int2Data {
	#if !macro
	public var x: Int;
	public var y: Int;

	public inline function new(x: Int, y: Int) {
		// the + 0.0 helps the optimizer realize it can collapse const Int operations
		this.x = x + 0;
		this.y = y + 0;
	}
	#end
}
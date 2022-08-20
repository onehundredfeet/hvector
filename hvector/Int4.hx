package hvector;
#if (vector_math_f32 && (cpp || hl || cs || java))
// override Int (usually f64) type with f32
//@:eager private typedef Int = Int;
#end
#if macro
import hvector.macro.Swizzle;
#end

@:nullSafety
abstract Int4(Int4Data) to Int4Data from Int4Data {

	#if !macro

	public static inline function up() : Int4 return new Int4(0, 0, 1, 0); 
	public static inline function down() : Int4 return new Int4(0, 0, -1,0); 
	public static inline function left() : Int4 return new Int4(-1, 0, 0,0); 
	public static inline function right() : Int4 return new Int4(1, 0, 0,0); 
	public static inline function one() : Int4 return new Int4(1, 1, 1, 1); 
	public static inline function zero() : Int4 return new Int4(0, 0,0,0); 
//	public static inline function positiveInfinity(): Int4  return new Int4(Math.POSITIVE_INFINITY, Math.POSITIVE_INFINITY, Math.POSITIVE_INFINITY, Math.POSITIVE_INFINITY); 


	public var x (get, set): Int;
	inline function get_x() return this.x;
	inline function set_x(v: Int) return this.x = v;
	public var y (get, set): Int;
	inline function get_y() return this.y;
	inline function set_y(v: Int) return this.y = v;
	public var z (get, set): Int;
	inline function get_z() return this.z;
	inline function set_z(v: Int) return this.z = v;
	public var w (get, set): Int;
	inline function get_w() return this.w;
	inline function set_w(v: Int) return this.w = v;

	public inline function new(x: Int, y: Int, z: Int, w: Int) {
		this = new Int4Data(x, y, z, w);
	}

	public inline function copyFrom(v: Int4) {
		x = v.x;
		y = v.y;
		z = v.z;
		w = v.w;
		return this;
	}

	public inline function clone() {
		return new Int4(x, y, z, w);
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
	public inline function abs(): Int4 {
		return new Int4(
			Std.int(Math.abs(x)),
			Std.int(Math.abs(y)),
			Std.int(Math.abs(z)),
			Std.int(Math.abs(w))
		);
	}
	public inline function sign(): Int4 {
		return new Int4(
			x > 0 ? 1 : (x < 0 ? -1 : 0),
			y > 0 ? 1 : (y < 0 ? -1 : 0),
			z > 0 ? 1 : (z < 0 ? -1 : 0),
			w > 0 ? 1 : (w < 0 ? -1 : 0)
		);
	}
	
	public extern overload inline function min(b: Int4): Int4 {
		return new Int4(
			b.x < x ? b.x : x,
			b.y < y ? b.y : y,
			b.z < z ? b.z : z,
			b.w < w ? b.w : w
		);
	}
	public extern overload inline function min(b: Int): Int4 {
		return new Int4(
			b < x ? b : x,
			b < y ? b : y,
			b < z ? b : z,
			b < w ? b : w
		);
	}
	public extern overload inline function max(b: Int4): Int4 {
		return new Int4(
			x < b.x ? b.x : x,
			y < b.y ? b.y : y,
			z < b.z ? b.z : z,
			w < b.w ? b.w : w
		);
	}
	public extern overload inline function max(b: Int): Int4 {
		return new Int4(
			x < b ? b : x,
			y < b ? b : y,
			z < b ? b : z,
			w < b ? b : w
		);
	}
	public extern overload inline function clamp(minLimit: Int4, maxLimit: Int4) {
		return max(minLimit).min(maxLimit);
	}
	public extern overload inline function clamp(minLimit: Int, maxLimit: Int) {
		return max(minLimit).min(maxLimit);
	}

	

	public extern overload inline function step(edge: Int4): Int4 {
		return new Int4(
			x < edge.x ? 0 : 1,
			y < edge.y ? 0 : 1,
			z < edge.z ? 0 : 1,
			w < edge.w ? 0 : 1
		);
	}
	public extern overload inline function step(edge: Int): Int4 {
		return new Int4(
			x < edge ? 0 : 1,
			y < edge ? 0 : 1,
			z < edge ? 0 : 1,
			w < edge ? 0 : 1
		);
	}

	

	// Geometric
	public inline function length(): Int {
		return Std.int(Math.sqrt(x*x + y*y + z*z + w*w));
	}	
	public inline function distance(b: Int4): Int {
		return (b - this).length();
	}
	public inline function dot(b: Int4): Int {
		return x * b.x + y * b.y + z * b.z + w * b.w;
	}
	

	public inline function toString() {
		return 'Int4(${x}, ${y}, ${z}, ${w})';
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
	inline function arrayWrite(i: Int, v: Int)
		return switch i {
			case 0: x = v;
			case 1: y = v;
			case 2: z = v;
			case 3: w = v;
			default: null;
		}

	@:op(-a)
	static inline function neg(a: Int4)
		return new Int4(-a.x, -a.y, -a.z, -a.w);

	@:op(++a)
	static inline function prefixIncrement(a: Int4) {
		++a.x; ++a.y; ++a.z; ++a.w;
		return a.clone();
	}

	@:op(--a)
	static inline function prefixDecrement(a: Int4) {
		--a.x; --a.y; --a.z; --a.w;
		return a.clone();
	}

	@:op(a++)
	static inline function postfixIncrement(a: Int4) {
		var ret = a.clone();
		++a.x; ++a.y; ++a.z; ++a.w;
		return ret;
	}

	@:op(a--)
	static inline function postfixDecrement(a: Int4) {
		var ret = a.clone();
		--a.x; --a.y; --a.z; --a.w;
		return ret;
	}

	// assignment overload should come before other binary ops to ensure they have priority
	@:op(a *= b)
	static inline function mulEq(a: Int4, b: Int4): Int4
		return a.copyFrom(a * b);

	/*
	@:op(a *= b)
	static inline function mulEqMat(a: Int4, b: Mat4): Int4
		return a.copyFrom(a * b);
*/
	@:op(a *= b)
	static inline function mulEqScalar(a: Int4, f: Int): Int4
		return a.copyFrom(a * f);

	@:op(a /= b)
	static inline function divEq(a: Int4, b: Int4): Int4
		return a.copyFrom(a / b);

	@:op(a /= b)
	static inline function divEqScalar(a: Int4, f: Int): Int4
		return a.copyFrom(a / f);

	@:op(a += b)
	static inline function addEq(a: Int4, b: Int4): Int4
		return a.copyFrom(a + b);

	@:op(a += b)
	static inline function addEqScalar(a: Int4, f: Int): Int4
		return a.copyFrom(a + f);

	@:op(a -= b)
	static inline function subEq(a: Int4, b: Int4): Int4
		return a.copyFrom(a - b);

	@:op(a -= b)
	static inline function subEqScalar(a: Int4, f: Int): Int4
		return a.copyFrom(a - f);

	@:op(a * b)
	static inline function mul(a: Int4, b: Int4): Int4
		return new Int4(Std.int(a.x * b.x), Std.int(a.y * b.y), Std.int(a.z * b.z), Std.int(a.w * b.w));

	@:op(a * b) @:commutative
	static inline function mulScalar(a: Int4, b: Int): Int4
		return new Int4(Std.int(a.x * b), Std.int(a.y * b), Std.int(a.z * b), Std.int(a.w * b));

	@:op(a / b)
	static inline function div(a: Int4, b: Int4): Int4
		return new Int4(Std.int(a.x / b.x), Std.int(a.y / b.y), Std.int(a.z / b.z), Std.int(a.w / b.w));

	@:op(a / b)
	static inline function divScalar(a: Int4, b: Int): Int4
		return new Int4(Std.int(a.x / b), Std.int(a.y / b), Std.int(a.z / b), Std.int(a.w / b));
	
	@:op(a / b)
	static inline function divScalarInv(a: Int, b: Int4): Int4
		return new Int4(Std.int(a / b.x), Std.int(a / b.y), Std.int(a / b.z), Std.int(a / b.w));

	@:op(a + b)
	static inline function add(a: Int4, b: Int4): Int4
		return new Int4(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w);

	@:op(a + b) @:commutative
	static inline function addScalar(a: Int4, b: Int): Int4
		return new Int4(a.x + b, a.y + b, a.z + b, a.w + b);

	@:op(a - b)
	static inline function sub(a: Int4, b: Int4): Int4
		return new Int4(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w);

	@:op(a - b)
	static inline function subScalar(a: Int4, b: Int): Int4
		return new Int4(a.x - b, a.y - b, a.z - b, a.w - b);

	@:op(b - a)
	static inline function subScalarInv(a: Int, b: Int4): Int4
		return new Int4(a - b.x, a - b.y, a - b.z, a - b.w);

	@:op(a == b)
	static inline function equal(a: Int4, b: Int4): Bool
		return a.x == b.x && a.y == b.y && a.z == b.z && a.w == b.w;

	@:op(a != b)
	static inline function notEqual(a: Int4, b: Int4): Bool
		return !equal(a, b);

	#end // !macro

	// macros
	@:op(a.b) macro function swizzleRead(self, name: String) {
		return Swizzle.swizzleReadExpr(self, name);
	}

	@:op(a.b) macro function swizzleWrite(self, name: String, value) {
		return Swizzle.swizzleWriteExpr(self, name, value);
	}

	@:overload(function<T>(arrayLike: T, index: Int): T {})
	public macro function copyIntoArray(self: haxe.macro.Expr.ExprOf<Int4>, array: haxe.macro.Expr.ExprOf<ArrayAccess<Int>>, index: haxe.macro.Expr.ExprOf<Int>) {
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
class Int4Data {
	#if !macro
	public var x: Int;
	public var y: Int;
	public var z: Int;
	public var w: Int;

	public inline function new(x: Int, y: Int, z: Int, w: Int) {
		// the + 0.0 helps the optimizer realize it can collapse const Int operations
		this.x = x + 0;
		this.y = y + 0;
		this.z = z + 0;
		this.w = w + 0;
	}
	#end
}
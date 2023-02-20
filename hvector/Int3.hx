package hvector;
#if (vector_math_f32 && (cpp || hl || cs || java))
// override Int (usually f64) type with f32
//@:eager private typedef Int = Single;
#end
#if macro
import hvector.macro.SwizzleF;
#end
@:nullSafety
abstract Int3(Int3Data) to Int3Data from Int3Data {

	#if !macro

	public static inline function up() : Int3 return new Int3(0, 0, 1); 
	public static inline function down() : Int3 return new Int3(0, 0, -1); 
	public static inline function left() : Int3 return new Int3(-1, 0, 0); 
	public static inline function right() : Int3 return new Int3(1, 0, 0); 
	public static inline function one() : Int3 return new Int3(1, 1, 1); 
	public static inline function zero() : Int3 return new Int3(0, 0, 0); 
	public static inline function fromArray(a : Array<Int>, x = 0, y = 1, z = 2): Int3  return new Int3(a[x], a[y], a[z]); 



	public var x (get, set): Int;
	inline function get_x() return this.x;
	inline function set_x(v: Int) return this.x = v;
	public var y (get, set): Int;
	inline function get_y() return this.y;
	inline function set_y(v: Int) return this.y = v;
	public var z (get, set): Int;
	inline function get_z() return this.z;
	inline function set_z(v: Int) return this.z = v;

	public inline function new(x: Int, y: Int, z: Int) {
		this = new Int3Data(x, y, z);
	}

	public inline function copyFrom(v: Int3) {
		x = v.x;
		y = v.y;
		z = v.z;
		return this;
	}

	public inline function clone() {
		return new Int3(x, y, z);
	}

	// special case for Int3
	public inline function cross(b: Int3)
		return new Int3(
			y * b.z - z * b.y,
			z * b.x - x * b.z,
			x * b.y - y * b.x
		);

	// Trigonometric

	// Common
	public inline function abs(): Int3 {
		return new Int3(
			Std.int(Math.abs(x)),
			Std.int(Math.abs(y)),
			Std.int(Math.abs(z))
		);
	}
	public inline function sign(): Int3 {
		return new Int3(
			x > 0 ? 1 : (x < 0 ? -1 : 0),
			y > 0 ? 1 : (y < 0 ? -1 : 0),
			z > 0 ? 1 : (z < 0 ? -1 : 0)
		);
	}
	
	

	public extern overload inline function min(b: Int3): Int3 {
		return new Int3(
			b.x < x ? b.x : x,
			b.y < y ? b.y : y,
			b.z < z ? b.z : z
		);
	}
	public extern overload inline function min(b: Int): Int3 {
		return new Int3(
			b < x ? b : x,
			b < y ? b : y,
			b < z ? b : z
		);
	}
	public extern overload inline function max(b: Int3): Int3 {
		return new Int3(
			x < b.x ? b.x : x,
			y < b.y ? b.y : y,
			z < b.z ? b.z : z
		);
	}
	public extern overload inline function max(b: Int): Int3 {
		return new Int3(
			x < b ? b : x,
			y < b ? b : y,
			z < b ? b : z
		);
	}
	public extern overload inline function clamp(minLimit: Int3, maxLimit: Int3) {
		return max(minLimit).min(maxLimit);
	}
	public extern overload inline function clamp(minLimit: Int, maxLimit: Int) {
		return max(minLimit).min(maxLimit);
	}



	// Geometric
	public inline function length(): Float {
		return Math.sqrt(x*x + y*y + z*z);
	}	
	public inline function distance(b: Int3): Float {
		return (b - this).length();
	}
	public inline function dot(b: Int3): Int {
		return x * b.x + y * b.y + z * b.z;
	}


	public inline function toString() {
		return 'Int3(${x}, ${y}, ${z})';
	}

	@:op([])
	inline function arrayRead(i: Int)
		return switch i {
			case 0: x;
			case 1: y;
			case 2: z;
			default: null;
		}

	@:op([])
	inline function arrayWrite(i: Int, v: Int)
		return switch i {
			case 0: x = v;
			case 1: y = v;
			case 2: z = v;
			default: null;
		}

	@:op(-a)
	static inline function neg(a: Int3)
		return new Int3(-a.x, -a.y, -a.z);

	@:op(++a)
	static inline function prefixIncrement(a: Int3) {
		++a.x; ++a.y; ++a.z;
		return a.clone();
	}

	@:op(--a)
	static inline function prefixDecrement(a: Int3) {
		--a.x; --a.y; --a.z;
		return a.clone();
	}

	@:op(a++)
	static inline function postfixIncrement(a: Int3) {
		var ret = a.clone();
		++a.x; ++a.y; ++a.z;
		return ret;
	}

	@:op(a--)
	static inline function postfixDecrement(a: Int3) {
		var ret = a.clone();
		--a.x; --a.y; --a.z;
		return ret;
	}

	// assignment overload should come before other binary ops to ensure they have priority
	@:op(a *= b)
	static inline function mulEq(a: Int3, b: Int3): Int3
		return a.copyFrom(a * b);


	@:op(a *= b)
	static inline function mulEqScalar(a: Int3, f: Int): Int3
		return a.copyFrom(a * f);

	@:op(a /= b)
	static inline function divEq(a: Int3, b: Int3): Int3
		return a.copyFrom(a / b);

	@:op(a /= b)
	static inline function divEqScalar(a: Int3, f: Int): Int3
		return a.copyFrom(a / f);

	@:op(a += b)
	static inline function addEq(a: Int3, b: Int3): Int3
		return a.copyFrom(a + b);

	@:op(a += b)
	static inline function addEqScalar(a: Int3, f: Int): Int3
		return a.copyFrom(a + f);

	@:op(a -= b)
	static inline function subEq(a: Int3, b: Int3): Int3
		return a.copyFrom(a - b);

	@:op(a -= b)
	static inline function subEqScalar(a: Int3, f: Int): Int3
		return a.copyFrom(a - f);

	@:op(a * b)
	static inline function mul(a: Int3, b: Int3): Int3
		return new Int3(a.x * b.x, a.y * b.y, a.z * b.z);

	@:op(a * b) @:commutative
	static inline function mulScalar(a: Int3, b: Int): Int3
		return new Int3(a.x * b, a.y * b, a.z * b);

	@:op(a / b)
	static inline function div(a: Int3, b: Int3): Int3
		return new Int3(Std.int(a.x / b.x), Std.int(a.y / b.y), Std.int(a.z / b.z));

	@:op(a / b)
	static inline function divScalar(a: Int3, b: Int): Int3
		return new Int3(Std.int(a.x / b), Std.int(a.y / b), Std.int(a.z / b));
	
	@:op(a / b)
	static inline function divScalarInv(a: Int, b: Int3): Int3
		return new Int3(Std.int(a / b.x), Std.int(a / b.y), Std.int(a / b.z));

	@:op(a + b)
	static inline function add(a: Int3, b: Int3): Int3
		return new Int3(a.x + b.x, a.y + b.y, a.z + b.z);

	@:op(a + b) @:commutative
	static inline function addScalar(a: Int3, b: Int): Int3
		return new Int3(a.x + b, a.y + b, a.z + b);

	@:op(a - b)
	static inline function sub(a: Int3, b: Int3): Int3
		return new Int3(a.x - b.x, a.y - b.y, a.z - b.z);

	@:op(a - b)
	static inline function subScalar(a: Int3, b: Int): Int3
		return new Int3(a.x - b, a.y - b, a.z - b);

	@:op(b - a)
	static inline function subScalarInv(a: Int, b: Int3): Int3
		return new Int3(a - b.x, a - b.y, a - b.z);

	@:op(a == b)
	static inline function equal(a: Int3, b: Int3): Bool
		return a.x == b.x && a.y == b.y && a.z == b.z;

	@:op(a != b)
	static inline function notEqual(a: Int3, b: Int3): Bool
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
	public macro function copyIntoArray(self: haxe.macro.Expr.ExprOf<Int3>, array: haxe.macro.Expr.ExprOf<ArrayAccess<Int>>, index: haxe.macro.Expr.ExprOf<Int>) {
		return macro {
			var self = $self;
			var array = $array;
			var i: Int = $index;
			array[0 + i] = self.x;
			array[1 + i] = self.y;
			array[2 + i] = self.z;
			array;
		}
	}
	
}

@:noCompletion
@:struct
class Int3Data {
	#if !macro
	public var x: Int;
	public var y: Int;
	public var z: Int;

	public inline function new(x: Int, y: Int, z: Int) {
		// the + 0.0 helps the optimizer realize it can collapse const Int operations
		this.x = x + 0;
		this.y = y + 0;
		this.z = z + 0;
	}
	#end
}

#if hl
abstract NativeArrayInt3(hl.NativeArray<Int>) to hl.NativeArray<Int> from hl.NativeArray<Int> {
	@:arrayAccess
	public inline function get(idx: Int) {
		return new Int3(this[idx * 3 + 0],this[idx * 3 + 0],this[idx * 3 + 0]);
	}


}
#end
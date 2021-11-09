package hvector;
#if (vector_math_f32 && (cpp || hl || cs || java))
// override Float (usually f64) type with f32
//@:eager private typedef Float = Float;
#end

abstract Float2x2(Float2x2Data) from Float2x2Data to Float2x2Data {

	#if !macro

	public inline function new(
		a00: Float, a01: Float,
		a10: Float, a11: Float
	) {
		this = new Float2x2Data(
			a00, a01,
			a10, a11
		);
	}

	public inline function copyFrom(v: Float2x2) {
		var v: Float2x2Data = v;
		this.c0.copyFrom(v.c0);
		this.c1.copyFrom(v.c1);
		return this;
	}

	public inline function clone(): Float2x2 {
		return new Float2x2(
			this.c0.x, this.c0.y,
			this.c1.x, this.c1.y
		);
	}

	public inline function matrixCompMult(n: Float2x2): Float2x2 {
		var n: Float2x2Data = n;
		return new Float2x2(
			this.c0.x * n.c0.x, this.c0.y * n.c0.y,
			this.c1.x * n.c1.x, this.c1.y * n.c1.y
		);
	}

	// extended methods

	public inline function transpose(): Float2x2 {
		return new Float2x2(
			this.c0.x, this.c1.x,
			this.c0.y, this.c1.y
		);
	}

	public inline function determinant(): Float {
		var m = this;
		return m.c0.x * m.c1.y - m.c1.x * m.c0.y;
	}

	public inline function inverse(): Float2x2 {
		var m = this;
		var f = 1.0 / determinant();
		return new Float2x2(
			m.c1.y * f, -m.c0.y * f,
			-m.c1.x * f, m.c0.x * f
		);
	}

	public inline function adjoint(): Float2x2 {
		var m = this;
		return new Float2x2(
			m.c1.y, -m.c0.y,
			-m.c1.x, m.c0.x
		);
	}

	public inline function toString() {
		return 'Float2x2(' +
			'${this.c0.x}, ${this.c0.y}, ' +
			'${this.c1.x}, ${this.c1.y}' +
		')';
	}

	@:op([])
	inline function arrayRead(i: Int)
		return switch i {
			case 0: this.c0.clone();
			case 1: this.c1.clone();
			default: null;
		}

	@:op([])
	inline function arrayWrite(i: Int, v: Float2)
		return switch i {
			case 0: this.c0.copyFrom(v);
			case 1: this.c1.copyFrom(v);
			default: null;
		}

	@:op(-a)
	static inline function neg(m: Float2x2) {
		var m: Float2x2Data = m;
		return new Float2x2(
			-m.c0.x, -m.c0.y,
			-m.c1.x, -m.c1.y
		);
	}

	@:op(++a)
	static inline function prefixIncrement(m: Float2x2) {
		var _m: Float2x2Data = m;
		++_m.c0.x; ++_m.c0.y;
		++_m.c1.x; ++_m.c1.y;
		return m.clone();
	}

	@:op(--a)
	static inline function prefixDecrement(m: Float2x2) {
		var _m: Float2x2Data = m;
		--_m.c0.x; --_m.c0.y;
		--_m.c1.x; --_m.c1.y;
		return m.clone();
	}

	@:op(a++)
	static inline function postfixIncrement(m: Float2x2) {
		var ret = m.clone();
		var m: Float2x2Data = m;
		++m.c0.x; ++m.c0.y;
		++m.c1.x; ++m.c1.y;
		return ret;
	}

	@:op(a--)
	static inline function postfixDecrement(m: Float2x2) {
		var ret = m.clone();
		var m: Float2x2Data = m;
		--m.c0.x; --m.c0.y;
		--m.c1.x; --m.c1.y;
		return ret;
	}

	// assignment overload should come before other binary ops to ensure they have priority
	@:op(a *= b)
	static inline function mulEq(a: Float2x2, b: Float2x2): Float2x2
		return a.copyFrom(a * b);

	@:op(a *= b)
	static inline function mulEqScalar(a: Float2x2, f: Float): Float2x2
		return a.copyFrom(a * f);

	@:op(a /= b)
	static inline function divEq(a: Float2x2, b: Float2x2): Float2x2
		return a.copyFrom(a / b);

	@:op(a /= b)
	static inline function divEqScalar(a: Float2x2, f: Float): Float2x2
		return a.copyFrom(a / f);

	@:op(a += b)
	static inline function addEq(a: Float2x2, b: Float2x2): Float2x2
		return a.copyFrom(a + b);

	@:op(a += b)
	static inline function addEqScalar(a: Float2x2, f: Float): Float2x2
		return a.copyFrom(a + f);

	@:op(a -= b)
	static inline function subEq(a: Float2x2, b: Float2x2): Float2x2
		return a.copyFrom(a - b);

	@:op(a -= b)
	static inline function subEqScalar(a: Float2x2, f: Float): Float2x2
		return a.copyFrom(a - f);

	@:op(a + b)
	static inline function add(m: Float2x2, n: Float2x2): Float2x2 {
		var m: Float2x2Data = m;
		var n: Float2x2Data = n;
		return new Float2x2(
			m.c0.x + n.c0.x, m.c0.y + n.c0.y,
			m.c1.x + n.c1.x, m.c1.y + n.c1.y
		);
	}

	@:op(a + b) @:commutative
	static inline function addScalar(m: Float2x2, f: Float): Float2x2 {
		var m: Float2x2Data = m;
		return new Float2x2(
			m.c0.x + f, m.c0.y + f,
			m.c1.x + f, m.c1.y + f
		);
	}

	@:op(a - b)
	static inline function sub(m: Float2x2, n: Float2x2): Float2x2 {
		var m: Float2x2Data = m;
		var n: Float2x2Data = n;
		return new Float2x2(
			m.c0.x - n.c0.x, m.c0.y - n.c0.y,
			m.c1.x - n.c1.x, m.c1.y - n.c1.y
		);
	}

	@:op(a - b)
	static inline function subScalar(m: Float2x2, f: Float): Float2x2 {
		var m: Float2x2Data = m;
		return new Float2x2(
			m.c0.x - f, m.c0.y - f,
			m.c1.x - f, m.c1.y - f
		);
	}

	@:op(a - b)
	static inline function subScalarInv(f: Float, m: Float2x2): Float2x2 {
		var m: Float2x2Data = m;
		return new Float2x2(
			f - m.c0.x, f - m.c0.y,
			f - m.c1.x, f - m.c1.y
		);
	}

	@:op(a * b)
	static inline function mul(m: Float2x2, n: Float2x2): Float2x2 {
		var m: Float2x2Data = m;
		var n: Float2x2Data = n;
		return new Float2x2(
			m.c0.x * n.c0.x + m.c1.x * n.c0.y,
			m.c0.y * n.c0.x + m.c1.y * n.c0.y,
			m.c0.x * n.c1.x + m.c1.x * n.c1.y,
			m.c0.y * n.c1.x + m.c1.y * n.c1.y
		);
	}

	@:op(a * b)
	static inline function postMulFloat2(m: Float2x2, v: Float2): Float2 {
		var m: Float2x2Data = m;
		return new Float2(
			m.c0.x * v.x + m.c1.x * v.y,
			m.c0.y * v.x + m.c1.y * v.y
		);
	}

	@:op(a * b)
	static inline function preMulFloat2(v: Float2, m: Float2x2): Float2 {
		var m: Float2x2Data = m;
		return new Float2(
			v.dot(m.c0),
			v.dot(m.c1)
		);
	}

	@:op(a * b) @:commutative
	static inline function mulScalar(m: Float2x2, f: Float): Float2x2 {
		var m: Float2x2Data = m;
		return new Float2x2(
			m.c0.x * f, m.c0.y * f, 
			m.c1.x * f, m.c1.y * f
		);
	}

	@:op(a / b)
	static inline function div(m: Float2x2, n: Float2x2): Float2x2 {
		return m.matrixCompMult(1.0 / n);
	}

	@:op(a / b)
	static inline function divScalar(m: Float2x2, f: Float): Float2x2 {
		var m: Float2x2Data = m;
		return new Float2x2(
			m.c0.x / f, m.c0.y / f,
			m.c1.x / f, m.c1.y / f
		);
	}

	@:op(a / b)
	static inline function divScalarInv(f: Float, m: Float2x2): Float2x2 {
		var m: Float2x2Data = m;
		return new Float2x2(
			f / m.c0.x, f / m.c0.y,
			f / m.c1.x, f / m.c1.y
		);
	}

	@:op(a == b)
	static inline function equal(m: Float2x2, n: Float2x2): Bool {
		var m: Float2x2Data = m;
		var n: Float2x2Data = n;
		return
			m.c0 == n.c0 &&
			m.c1 == n.c1;
	}

	@:op(a != b)
	static inline function notEqual(m: Float2x2, n: Float2x2): Bool
		return !equal(m, n);

	#end // !macro

	/**
		Copies matrix elements in column-major order into a type that supports array-write access
	**/
	@:overload(function<T>(arrayLike: T, index: Int): T {})
	public macro function copyIntoArray(self: haxe.macro.Expr.ExprOf<Float2x2>, array: haxe.macro.Expr.ExprOf<ArrayAccess<Float>>, index: haxe.macro.Expr.ExprOf<Int>) {
		return macro  {
			var self = $self;
			var array = $array;
			var i: Int = $index;
			self[0].copyIntoArray(array, i);
			self[1].copyIntoArray(array, i + 2);
			array;
		}
	}

}

@:noCompletion
class Float2x2Data {
	#if !macro
	public var c0: Float2;
	public var c1: Float2;

	public inline function new(
		a00: Float, a01: Float,
		a10: Float, a11: Float
	) {
		c0 = new Float2(a00, a01);
		c1 = new Float2(a10, a11);
	}
	#end
}
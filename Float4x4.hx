#if (vector_math_f32 && (cpp || hl || cs || java))
// override Float (usually f64) type with f32
//@:eager private typedef Float = Float;
#end

abstract Float4x4(Float4x4Data) from Float4x4Data to Float4x4Data {

	#if !macro

	public inline function new(
		a00: Float, a01: Float, a02: Float, a03: Float,
		a10: Float, a11: Float, a12: Float, a13: Float,
		a20: Float, a21: Float, a22: Float, a23: Float,
		a30: Float, a31: Float, a32: Float, a33: Float
	) {
		this = new Float4x4Data(
			a00, a01, a02, a03,
			a10, a11, a12, a13,
			a20, a21, a22, a23,
			a30, a31, a32, a33
		);
	}
	
	public inline function copyFrom(v: Float4x4) {
		var v: Float4x4Data = v;
		this.c0.copyFrom(v.c0);
		this.c1.copyFrom(v.c1);
		this.c2.copyFrom(v.c2);
		this.c3.copyFrom(v.c3);
		return this;
	}

	public inline function clone(): Float4x4 {
		return new Float4x4(
			this.c0.x, this.c0.y, this.c0.z, this.c0.w,
			this.c1.x, this.c1.y, this.c1.z, this.c1.w,
			this.c2.x, this.c2.y, this.c2.z, this.c2.w,
			this.c3.x, this.c3.y, this.c3.z, this.c3.w
		);
	}
	
	public inline function matrixCompMult(n: Float4x4): Float4x4 {
		var m = this;
		var n: Float4x4Data = n;
		return new Float4x4(
			m.c0.x * n.c0.x, m.c0.y * n.c0.y, m.c0.z * n.c0.z, m.c0.w * n.c0.w,
			m.c1.x * n.c1.x, m.c1.y * n.c1.y, m.c1.z * n.c1.z, m.c1.w * n.c1.w,
			m.c2.x * n.c2.x, m.c2.y * n.c2.y, m.c2.z * n.c2.z, m.c2.w * n.c2.w,
			m.c3.x * n.c3.x, m.c3.y * n.c3.y, m.c3.z * n.c3.z, m.c3.w * n.c3.w
		);
	}

	// extended methods

	public inline function transpose(): Float4x4 {
		var m = this;
		return new Float4x4(
			m.c0.x, m.c1.x, m.c2.x, m.c3.x,
			m.c0.y, m.c1.y, m.c2.y, m.c3.y,
			m.c0.z, m.c1.z, m.c2.z, m.c3.z,
			m.c0.w, m.c1.w, m.c2.w, m.c3.w
		);
	}

	public inline function determinant(): Float {
		var m = this;
		var b0 = m.c0.x * m.c1.y - m.c0.y * m.c1.x;
		var b1 = m.c0.x * m.c1.z - m.c0.z * m.c1.x;
		var b2 = m.c0.y * m.c1.z - m.c0.z * m.c1.y;
		var b3 = m.c2.x * m.c3.y - m.c2.y * m.c3.x;
		var b4 = m.c2.x * m.c3.z - m.c2.z * m.c3.x;
		var b5 = m.c2.y * m.c3.z - m.c2.z * m.c3.y;
		var b6 = m.c0.x * b5 - m.c0.y * b4 + m.c0.z * b3;
		var b7 = m.c1.x * b5 - m.c1.y * b4 + m.c1.z * b3;
		var b8 = m.c2.x * b2 - m.c2.y * b1 + m.c2.z * b0;
		var b9 = m.c3.x * b2 - m.c3.y * b1 + m.c3.z * b0;
		return m.c1.w * b6 - m.c0.w * b7 + m.c3.w * b8 - m.c2.w * b9;
	}

	public inline function inverse(): Float4x4 {
		var m = this;
		var b00 = m.c0.x * m.c1.y - m.c0.y * m.c1.x;
		var b01 = m.c0.x * m.c1.z - m.c0.z * m.c1.x;
		var b02 = m.c0.x * m.c1.w - m.c0.w * m.c1.x;
		var b03 = m.c0.y * m.c1.z - m.c0.z * m.c1.y;
		var b04 = m.c0.y * m.c1.w - m.c0.w * m.c1.y;
		var b05 = m.c0.z * m.c1.w - m.c0.w * m.c1.z;
		var b06 = m.c2.x * m.c3.y - m.c2.y * m.c3.x;
		var b07 = m.c2.x * m.c3.z - m.c2.z * m.c3.x;
		var b08 = m.c2.x * m.c3.w - m.c2.w * m.c3.x;
		var b09 = m.c2.y * m.c3.z - m.c2.z * m.c3.y;
		var b10 = m.c2.y * m.c3.w - m.c2.w * m.c3.y;
		var b11 = m.c2.z * m.c3.w - m.c2.w * m.c3.z;

		// determinant
		var det = b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06;

		var f = 1.0 / det;

		return new Float4x4(
			(m.c1.y * b11 - m.c1.z * b10 + m.c1.w * b09) * f,
			(m.c0.z * b10 - m.c0.y * b11 - m.c0.w * b09) * f,
			(m.c3.y * b05 - m.c3.z * b04 + m.c3.w * b03) * f,
			(m.c2.z * b04 - m.c2.y * b05 - m.c2.w * b03) * f,
			(m.c1.z * b08 - m.c1.x * b11 - m.c1.w * b07) * f,
			(m.c0.x * b11 - m.c0.z * b08 + m.c0.w * b07) * f,
			(m.c3.z * b02 - m.c3.x * b05 - m.c3.w * b01) * f,
			(m.c2.x * b05 - m.c2.z * b02 + m.c2.w * b01) * f,
			(m.c1.x * b10 - m.c1.y * b08 + m.c1.w * b06) * f,
			(m.c0.y * b08 - m.c0.x * b10 - m.c0.w * b06) * f,
			(m.c3.x * b04 - m.c3.y * b02 + m.c3.w * b00) * f,
			(m.c2.y * b02 - m.c2.x * b04 - m.c2.w * b00) * f,
			(m.c1.y * b07 - m.c1.x * b09 - m.c1.z * b06) * f,
			(m.c0.x * b09 - m.c0.y * b07 + m.c0.z * b06) * f,
			(m.c3.y * b01 - m.c3.x * b03 - m.c3.z * b00) * f,
			(m.c2.x * b03 - m.c2.y * b01 + m.c2.z * b00) * f
		);
	}

	public inline function adjoint(): Float4x4 {
		var m = this;
		var b00 = m.c0.x * m.c1.y - m.c0.y * m.c1.x;
		var b01 = m.c0.x * m.c1.z - m.c0.z * m.c1.x;
		var b02 = m.c0.x * m.c1.w - m.c0.w * m.c1.x;
		var b03 = m.c0.y * m.c1.z - m.c0.z * m.c1.y;
		var b04 = m.c0.y * m.c1.w - m.c0.w * m.c1.y;
		var b05 = m.c0.z * m.c1.w - m.c0.w * m.c1.z;
		var b06 = m.c2.x * m.c3.y - m.c2.y * m.c3.x;
		var b07 = m.c2.x * m.c3.z - m.c2.z * m.c3.x;
		var b08 = m.c2.x * m.c3.w - m.c2.w * m.c3.x;
		var b09 = m.c2.y * m.c3.z - m.c2.z * m.c3.y;
		var b10 = m.c2.y * m.c3.w - m.c2.w * m.c3.y;
		var b11 = m.c2.z * m.c3.w - m.c2.w * m.c3.z;
		return new Float4x4(
			m.c1.y * b11 - m.c1.z * b10 + m.c1.w * b09,
			m.c0.z * b10 - m.c0.y * b11 - m.c0.w * b09,
			m.c3.y * b05 - m.c3.z * b04 + m.c3.w * b03,
			m.c2.z * b04 - m.c2.y * b05 - m.c2.w * b03,
			m.c1.z * b08 - m.c1.x * b11 - m.c1.w * b07,
			m.c0.x * b11 - m.c0.z * b08 + m.c0.w * b07,
			m.c3.z * b02 - m.c3.x * b05 - m.c3.w * b01,
			m.c2.x * b05 - m.c2.z * b02 + m.c2.w * b01,
			m.c1.x * b10 - m.c1.y * b08 + m.c1.w * b06,
			m.c0.y * b08 - m.c0.x * b10 - m.c0.w * b06,
			m.c3.x * b04 - m.c3.y * b02 + m.c3.w * b00,
			m.c2.y * b02 - m.c2.x * b04 - m.c2.w * b00,
			m.c1.y * b07 - m.c1.x * b09 - m.c1.z * b06,
			m.c0.x * b09 - m.c0.y * b07 + m.c0.z * b06,
			m.c3.y * b01 - m.c3.x * b03 - m.c3.z * b00,
			m.c2.x * b03 - m.c2.y * b01 + m.c2.z * b00
		);
	}
	
	public inline function toString() {
		return 'Float4x4(' +
			'${this.c0.x}, ${this.c0.y}, ${this.c0.z}, ${this.c0.w}, ' +
			'${this.c1.x}, ${this.c1.y}, ${this.c1.z}, ${this.c1.w}, ' +
			'${this.c2.x}, ${this.c2.y}, ${this.c2.z}, ${this.c2.w}, ' +
			'${this.c3.x}, ${this.c3.y}, ${this.c3.z}, ${this.c3.w}' +
		')';
	}

	@:op([])
	inline function arrayRead(i: Int)
		return switch i {
			case 0: this.c0.clone();
			case 1: this.c1.clone();
			case 2: this.c2.clone();
			case 3: this.c3.clone();
			default: null;
		}

	@:op([])
	inline function arrayWrite(i: Int, v: Float4)
		return switch i {
			case 0: this.c0.copyFrom(v);
			case 1: this.c1.copyFrom(v);
			case 2: this.c2.copyFrom(v);
			case 3: this.c3.copyFrom(v);
			default: null;
		}

	@:op(-a)
	static inline function neg(m: Float4x4) {
		var m: Float4x4Data = m;
		return new Float4x4(
			-m.c0.x, -m.c0.y, -m.c0.z, -m.c0.w,
			-m.c1.x, -m.c1.y, -m.c1.z, -m.c1.w,
			-m.c2.x, -m.c2.y, -m.c2.z, -m.c2.w,
			-m.c3.x, -m.c3.y, -m.c3.z, -m.c3.w
		);
	}

	@:op(++a)
	static inline function prefixIncrement(m: Float4x4) {
		var _m: Float4x4Data = m;
		++_m.c0; ++_m.c1; ++_m.c2; ++_m.c3;
		return m.clone();
	}

	@:op(--a)
	static inline function prefixDecrement(m: Float4x4) {
		var _m: Float4x4Data = m;
		--_m.c0; --_m.c1; --_m.c2; --_m.c3;
		return m.clone();
	}

	@:op(a++)
	static inline function postfixIncrement(m: Float4x4) {
		var ret = m.clone();
		var m: Float4x4Data = m;
		++m.c0; ++m.c1; ++m.c2; ++m.c3;
		return ret;
	}

	@:op(a--)
	static inline function postfixDecrement(m: Float4x4) {
		var ret = m.clone();
		var m: Float4x4Data = m;
		--m.c0; --m.c1; --m.c2; --m.c3;
		return ret;
	}

	// assignment overload should come before other binary ops to ensure they have priority
	@:op(a *= b)
	static inline function mulEq(a: Float4x4, b: Float4x4): Float4x4
		return a.copyFrom(a * b);

	@:op(a *= b)
	static inline function mulEqScalar(a: Float4x4, f: Float): Float4x4
		return a.copyFrom(a * f);

	@:op(a /= b)
	static inline function divEq(a: Float4x4, b: Float4x4): Float4x4
		return a.copyFrom(a / b);

	@:op(a /= b)
	static inline function divEqScalar(a: Float4x4, f: Float): Float4x4
		return a.copyFrom(a / f);

	@:op(a += b)
	static inline function addEq(a: Float4x4, b: Float4x4): Float4x4
		return a.copyFrom(a + b);

	@:op(a += b)
	static inline function addEqScalar(a: Float4x4, f: Float): Float4x4
		return a.copyFrom(a + f);

	@:op(a -= b)
	static inline function subEq(a: Float4x4, b: Float4x4): Float4x4
		return a.copyFrom(a - b);

	@:op(a -= b)
	static inline function subEqScalar(a: Float4x4, f: Float): Float4x4
		return a.copyFrom(a - f);

	@:op(a + b)
	static inline function add(m: Float4x4, n: Float4x4): Float4x4 {
		var m: Float4x4Data = m;
		var n: Float4x4Data = n;
		return new Float4x4(
			m.c0.x + n.c0.x, m.c0.y + n.c0.y, m.c0.z + n.c0.z, m.c0.w + n.c0.w,
			m.c1.x + n.c1.x, m.c1.y + n.c1.y, m.c1.z + n.c1.z, m.c1.w + n.c1.w,
			m.c2.x + n.c2.x, m.c2.y + n.c2.y, m.c2.z + n.c2.z, m.c2.w + n.c2.w,
			m.c3.x + n.c3.x, m.c3.y + n.c3.y, m.c3.z + n.c3.z, m.c3.w + n.c3.w
		);
	}

	@:op(a + b) @:commutative
	static inline function addScalar(m: Float4x4, f: Float): Float4x4 {
		var m: Float4x4Data = m;
		return new Float4x4(
			m.c0.x + f, m.c0.y + f, m.c0.z + f, m.c0.w + f,
			m.c1.x + f, m.c1.y + f, m.c1.z + f, m.c1.w + f,
			m.c2.x + f, m.c2.y + f, m.c2.z + f, m.c2.w + f,
			m.c3.x + f, m.c3.y + f, m.c3.z + f, m.c3.w + f
		);
	}

	@:op(a - b)
	static inline function sub(m: Float4x4, n: Float4x4): Float4x4 {
		var m: Float4x4Data = m;
		var n: Float4x4Data = n;
		return new Float4x4(
			m.c0.x - n.c0.x, m.c0.y - n.c0.y, m.c0.z - n.c0.z, m.c0.w - n.c0.w,
			m.c1.x - n.c1.x, m.c1.y - n.c1.y, m.c1.z - n.c1.z, m.c1.w - n.c1.w,
			m.c2.x - n.c2.x, m.c2.y - n.c2.y, m.c2.z - n.c2.z, m.c2.w - n.c2.w,
			m.c3.x - n.c3.x, m.c3.y - n.c3.y, m.c3.z - n.c3.z, m.c3.w - n.c3.w
		);
	}

	@:op(a - b)
	static inline function subScalar(m: Float4x4, f: Float): Float4x4 {
		var m: Float4x4Data = m;
		return new Float4x4(
			m.c0.x - f, m.c0.y - f, m.c0.z - f, m.c0.w - f,
			m.c1.x - f, m.c1.y - f, m.c1.z - f, m.c1.w - f,
			m.c2.x - f, m.c2.y - f, m.c2.z - f, m.c2.w - f,
			m.c3.x - f, m.c3.y - f, m.c3.z - f, m.c3.w - f
		);
	}

	@:op(a - b)
	static inline function subScalarInv(f: Float, m: Float4x4): Float4x4 {
		var m: Float4x4Data = m;
		return new Float4x4(
			f - m.c0.x, f - m.c0.y, f - m.c0.z, f - m.c0.w,
			f - m.c1.x, f - m.c1.y, f - m.c1.z, f - m.c1.w,
			f - m.c2.x, f - m.c2.y, f - m.c2.z, f - m.c2.w,
			f - m.c3.x, f - m.c3.y, f - m.c3.z, f - m.c3.w
		);
	}

	

	@:op(a * b)
	static inline function mul(m: Float4x4, n: Float4x4): Float4x4 {
		var m: Float4x4Data = m;
		var n: Float4x4Data = n;
		return new Float4x4(
			m.c0.x * n.c0.x + m.c1.x * n.c0.y + m.c2.x * n.c0.z + m.c3.x * n.c0.w,
			m.c0.y * n.c0.x + m.c1.y * n.c0.y + m.c2.y * n.c0.z + m.c3.y * n.c0.w,
			m.c0.z * n.c0.x + m.c1.z * n.c0.y + m.c2.z * n.c0.z + m.c3.z * n.c0.w,
			m.c0.w * n.c0.x + m.c1.w * n.c0.y + m.c2.w * n.c0.z + m.c3.w * n.c0.w,
			m.c0.x * n.c1.x + m.c1.x * n.c1.y + m.c2.x * n.c1.z + m.c3.x * n.c1.w,
			m.c0.y * n.c1.x + m.c1.y * n.c1.y + m.c2.y * n.c1.z + m.c3.y * n.c1.w,
			m.c0.z * n.c1.x + m.c1.z * n.c1.y + m.c2.z * n.c1.z + m.c3.z * n.c1.w,
			m.c0.w * n.c1.x + m.c1.w * n.c1.y + m.c2.w * n.c1.z + m.c3.w * n.c1.w,
			m.c0.x * n.c2.x + m.c1.x * n.c2.y + m.c2.x * n.c2.z + m.c3.x * n.c2.w,
			m.c0.y * n.c2.x + m.c1.y * n.c2.y + m.c2.y * n.c2.z + m.c3.y * n.c2.w,
			m.c0.z * n.c2.x + m.c1.z * n.c2.y + m.c2.z * n.c2.z + m.c3.z * n.c2.w,
			m.c0.w * n.c2.x + m.c1.w * n.c2.y + m.c2.w * n.c2.z + m.c3.w * n.c2.w,
			m.c0.x * n.c3.x + m.c1.x * n.c3.y + m.c2.x * n.c3.z + m.c3.x * n.c3.w,
			m.c0.y * n.c3.x + m.c1.y * n.c3.y + m.c2.y * n.c3.z + m.c3.y * n.c3.w,
			m.c0.z * n.c3.x + m.c1.z * n.c3.y + m.c2.z * n.c3.z + m.c3.z * n.c3.w,
			m.c0.w * n.c3.x + m.c1.w * n.c3.y + m.c2.w * n.c3.z + m.c3.w * n.c3.w
		);
	}
	
	@:op(a * b)
	static inline function postMulFloat4(m: Float4x4, v: Float4): Float4 {
		var m: Float4x4Data = m;
		return new Float4(
			m.c0.x * v.x + m.c1.x * v.y + m.c2.x * v.z + m.c3.x * v.w,
			m.c0.y * v.x + m.c1.y * v.y + m.c2.y * v.z + m.c3.y * v.w,
			m.c0.z * v.x + m.c1.z * v.y + m.c2.z * v.z + m.c3.z * v.w,
			m.c0.w * v.x + m.c1.w * v.y + m.c2.w * v.z + m.c3.w * v.w
		);
	}

	@:op(a * b)
	static inline function preMulFloat4(v: Float4, m: Float4x4): Float4 {
		var m: Float4x4Data = m;
		return new Float4(
			v.dot(m.c0),
			v.dot(m.c1),
			v.dot(m.c2),
			v.dot(m.c3)
		);
	}

	@:op(a * b) @:commutative
	static inline function mulScalar(m: Float4x4, f: Float): Float4x4 {
		var m: Float4x4Data = m;
		return new Float4x4(
			m.c0.x * f, m.c0.y * f, m.c0.z * f, m.c0.w * f,
			m.c1.x * f, m.c1.y * f, m.c1.z * f, m.c1.w * f,
			m.c2.x * f, m.c2.y * f, m.c2.z * f, m.c2.w * f,
			m.c3.x * f, m.c3.y * f, m.c3.z * f, m.c3.w * f
		);
	}

	@:op(a / b)
	static inline function div(m: Float4x4, n: Float4x4): Float4x4
		return m.matrixCompMult(1.0 / n);

	@:op(a / b)
	static inline function divScalar(m: Float4x4, f: Float): Float4x4 {
		var m: Float4x4Data = m;
		return new Float4x4(
			m.c0.x / f, m.c0.y / f, m.c0.z / f, m.c0.w / f,
			m.c1.x / f, m.c1.y / f, m.c1.z / f, m.c1.w / f,
			m.c2.x / f, m.c2.y / f, m.c2.z / f, m.c2.w / f,
			m.c3.x / f, m.c3.y / f, m.c3.z / f, m.c3.w / f
		);
	}

	@:op(a / b)
	static inline function divScalarInv(f: Float, m: Float4x4): Float4x4 {
		var m: Float4x4Data = m;
		return new Float4x4(
			f / m.c0.x, f / m.c0.y, f / m.c0.z, f / m.c0.w,
			f / m.c1.x, f / m.c1.y, f / m.c1.z, f / m.c1.w,
			f / m.c2.x, f / m.c2.y, f / m.c2.z, f / m.c2.w,
			f / m.c3.x, f / m.c3.y, f / m.c3.z, f / m.c3.w
		);
	}

	@:op(a == b)
	static inline function equal(m: Float4x4, n: Float4x4): Bool {
		var m: Float4x4Data = m;
		var n: Float4x4Data = n;
		return
			m.c0 == n.c0 &&
			m.c1 == n.c1 &&
			m.c2 == n.c2 &&
			m.c3 == n.c3;
	}

	@:op(a != b)
	static inline function notEqual(m: Float4x4, n: Float4x4): Bool
		return !equal(m, n);

	#end // !macro

	/**
		Copies matrix elements in column-major order into a type that supports array-write access
	**/
	@:overload(function<T>(arrayLike: T, index: Int): T {})
	public macro function copyIntoArray(self: haxe.macro.Expr.ExprOf<Float4x4>, array: haxe.macro.Expr.ExprOf<ArrayAccess<Float>>, index: haxe.macro.Expr.ExprOf<Int>) {
		return macro  {
			var self = $self;
			var array = $array;
			var i: Int = $index;
			self[0].copyIntoArray(array, i);
			self[1].copyIntoArray(array, i + 4);
			self[2].copyIntoArray(array, i + 8);
			self[3].copyIntoArray(array, i + 12);
			array;
		}
	}

}

@:noCompletion
class Float4x4Data {
	#if !macro
	public var c0: Float4;
	public var c1: Float4;
	public var c2: Float4;
	public var c3: Float4;

	public inline function new(
		a00: Float, a01: Float, a02: Float, a03: Float,
		a10: Float, a11: Float, a12: Float, a13: Float,
		a20: Float, a21: Float, a22: Float, a23: Float,
		a30: Float, a31: Float, a32: Float, a33: Float
	) {
		c0 = new Float4(a00, a01, a02, a03);
		c1 = new Float4(a10, a11, a12, a13);
		c2 = new Float4(a20, a21, a22, a23);
		c3 = new Float4(a30, a31, a32, a33);
	}
	#end
}
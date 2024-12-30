package hvector;
#if (vector_math_f32 && (cpp || hl || cs || java))
// override Float (usually f64) type with f32
//@:eager private typedef Float = Float;
#end

@:forward
abstract Float4x4(Float4x4Data) from Float4x4Data to Float4x4Data {

	
	#if !macro
	public static final identity = new Float4x4(
		1.0, 0., 0., 0.,
		0.0, 1., 0., 0.,
		0.0, 0., 1., 0.,
		0.0, 0., 0., 1.
		);
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
		this.c0x = v.c0x; this.c0y = v.c0y; this.c0z = v.c0z; this.c0w = v.c0w;
		this.c1x = v.c1x; this.c1y = v.c1y; this.c1z = v.c1z; this.c1w = v.c1w;
		this.c2x = v.c2x; this.c2y = v.c2y; this.c2z = v.c2z; this.c2w = v.c2w;
		this.c3x = v.c3x; this.c3y = v.c3y; this.c3z = v.c3z; this.c3w = v.c3w;
		return this;
	}

	public inline function clone(): Float4x4 {
		return new Float4x4(
			this.c0x, this.c0y, this.c0z, this.c0w,
			this.c1x, this.c1y, this.c1z, this.c1w,
			this.c2x, this.c2y, this.c2z, this.c2w,
			this.c3x, this.c3y, this.c3z, this.c3w
		);
	}
	
	public inline function matrixCompMult(n: Float4x4): Float4x4 {
		var m = this;
		var n: Float4x4Data = n;
		return new Float4x4(
			m.c0x * n.c0x, m.c0y * n.c0y, m.c0z * n.c0z, m.c0w * n.c0w,
			m.c1x * n.c1x, m.c1y * n.c1y, m.c1z * n.c1z, m.c1w * n.c1w,
			m.c2x * n.c2x, m.c2y * n.c2y, m.c2z * n.c2z, m.c2w * n.c2w,
			m.c3x * n.c3x, m.c3y * n.c3y, m.c3z * n.c3z, m.c3w * n.c3w
		);
	}

	// extended methods

	public inline function transpose(): Float4x4 {
		var m = this;
		return new Float4x4(
			m.c0x, m.c1x, m.c2x, m.c3x,
			m.c0y, m.c1y, m.c2y, m.c3y,
			m.c0z, m.c1z, m.c2z, m.c3z,
			m.c0w, m.c1w, m.c2w, m.c3w
		);
	}

	public inline function determinant(): Float {
		var m = this;
		var b0 = m.c0x * m.c1y - m.c0y * m.c1x;
		var b1 = m.c0x * m.c1z - m.c0z * m.c1x;
		var b2 = m.c0y * m.c1z - m.c0z * m.c1y;
		var b3 = m.c2x * m.c3y - m.c2y * m.c3x;
		var b4 = m.c2x * m.c3z - m.c2z * m.c3x;
		var b5 = m.c2y * m.c3z - m.c2z * m.c3y;
		var b6 = m.c0x * b5 - m.c0y * b4 + m.c0z * b3;
		var b7 = m.c1x * b5 - m.c1y * b4 + m.c1z * b3;
		var b8 = m.c2x * b2 - m.c2y * b1 + m.c2z * b0;
		var b9 = m.c3x * b2 - m.c3y * b1 + m.c3z * b0;
		return m.c1w * b6 - m.c0w * b7 + m.c3w * b8 - m.c2w * b9;
	}

	public inline function inverse(): Float4x4 {
		var m = this;
		var b00 = m.c0x * m.c1y - m.c0y * m.c1x;
		var b01 = m.c0x * m.c1z - m.c0z * m.c1x;
		var b02 = m.c0x * m.c1w - m.c0w * m.c1x;
		var b03 = m.c0y * m.c1z - m.c0z * m.c1y;
		var b04 = m.c0y * m.c1w - m.c0w * m.c1y;
		var b05 = m.c0z * m.c1w - m.c0w * m.c1z;
		var b06 = m.c2x * m.c3y - m.c2y * m.c3x;
		var b07 = m.c2x * m.c3z - m.c2z * m.c3x;
		var b08 = m.c2x * m.c3w - m.c2w * m.c3x;
		var b09 = m.c2y * m.c3z - m.c2z * m.c3y;
		var b10 = m.c2y * m.c3w - m.c2w * m.c3y;
		var b11 = m.c2z * m.c3w - m.c2w * m.c3z;

		// determinant
		var det = b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06;

		var f = 1.0 / det;

		return new Float4x4(
			(m.c1y * b11 - m.c1z * b10 + m.c1w * b09) * f,
			(m.c0z * b10 - m.c0y * b11 - m.c0w * b09) * f,
			(m.c3y * b05 - m.c3z * b04 + m.c3w * b03) * f,
			(m.c2z * b04 - m.c2y * b05 - m.c2w * b03) * f,
			(m.c1z * b08 - m.c1x * b11 - m.c1w * b07) * f,
			(m.c0x * b11 - m.c0z * b08 + m.c0w * b07) * f,
			(m.c3z * b02 - m.c3x * b05 - m.c3w * b01) * f,
			(m.c2x * b05 - m.c2z * b02 + m.c2w * b01) * f,
			(m.c1x * b10 - m.c1y * b08 + m.c1w * b06) * f,
			(m.c0y * b08 - m.c0x * b10 - m.c0w * b06) * f,
			(m.c3x * b04 - m.c3y * b02 + m.c3w * b00) * f,
			(m.c2y * b02 - m.c2x * b04 - m.c2w * b00) * f,
			(m.c1y * b07 - m.c1x * b09 - m.c1z * b06) * f,
			(m.c0x * b09 - m.c0y * b07 + m.c0z * b06) * f,
			(m.c3y * b01 - m.c3x * b03 - m.c3z * b00) * f,
			(m.c2x * b03 - m.c2y * b01 + m.c2z * b00) * f
		);
	}

	public inline function adjoint(): Float4x4 {
		var m = this;
		var b00 = m.c0x * m.c1y - m.c0y * m.c1x;
		var b01 = m.c0x * m.c1z - m.c0z * m.c1x;
		var b02 = m.c0x * m.c1w - m.c0w * m.c1x;
		var b03 = m.c0y * m.c1z - m.c0z * m.c1y;
		var b04 = m.c0y * m.c1w - m.c0w * m.c1y;
		var b05 = m.c0z * m.c1w - m.c0w * m.c1z;
		var b06 = m.c2x * m.c3y - m.c2y * m.c3x;
		var b07 = m.c2x * m.c3z - m.c2z * m.c3x;
		var b08 = m.c2x * m.c3w - m.c2w * m.c3x;
		var b09 = m.c2y * m.c3z - m.c2z * m.c3y;
		var b10 = m.c2y * m.c3w - m.c2w * m.c3y;
		var b11 = m.c2z * m.c3w - m.c2w * m.c3z;
		return new Float4x4(
			m.c1y * b11 - m.c1z * b10 + m.c1w * b09,
			m.c0z * b10 - m.c0y * b11 - m.c0w * b09,
			m.c3y * b05 - m.c3z * b04 + m.c3w * b03,
			m.c2z * b04 - m.c2y * b05 - m.c2w * b03,
			m.c1z * b08 - m.c1x * b11 - m.c1w * b07,
			m.c0x * b11 - m.c0z * b08 + m.c0w * b07,
			m.c3z * b02 - m.c3x * b05 - m.c3w * b01,
			m.c2x * b05 - m.c2z * b02 + m.c2w * b01,
			m.c1x * b10 - m.c1y * b08 + m.c1w * b06,
			m.c0y * b08 - m.c0x * b10 - m.c0w * b06,
			m.c3x * b04 - m.c3y * b02 + m.c3w * b00,
			m.c2y * b02 - m.c2x * b04 - m.c2w * b00,
			m.c1y * b07 - m.c1x * b09 - m.c1z * b06,
			m.c0x * b09 - m.c0y * b07 + m.c0z * b06,
			m.c3y * b01 - m.c3x * b03 - m.c3z * b00,
			m.c2x * b03 - m.c2y * b01 + m.c2z * b00
		);
	}
	
	public inline function toString() {
		return 'Float4x4(' +
			'${this.c0x}, ${this.c0y}, ${this.c0z}, ${this.c0w}, ' +
			'${this.c1x}, ${this.c1y}, ${this.c1z}, ${this.c1w}, ' +
			'${this.c2x}, ${this.c2y}, ${this.c2z}, ${this.c2w}, ' +
			'${this.c3x}, ${this.c3y}, ${this.c3z}, ${this.c3w}' +
		')';
	}

	// @:op([])
	// inline function arrayRead(i: Int)
	// 	return switch i {
	// 		case 0: this.c0clone();
	// 		case 1: this.c1clone();
	// 		case 2: this.c2clone();
	// 		case 3: this.c3clone();
	// 		default: null;
	// 	}

	// @:op([])
	// inline function arrayWrite(i: Int, v: Float4)
	// 	return switch i {
	// 		case 0: this.c0copyFrom(v);
	// 		case 1: this.c1copyFrom(v);
	// 		case 2: this.c2copyFrom(v);
	// 		case 3: this.c3copyFrom(v);
	// 		default: null;
	// 	}

	@:op(-a)
	static inline function neg(m: Float4x4) {
		var m: Float4x4Data = m;
		return new Float4x4(
			-m.c0x, -m.c0y, -m.c0z, -m.c0w,
			-m.c1x, -m.c1y, -m.c1z, -m.c1w,
			-m.c2x, -m.c2y, -m.c2z, -m.c2w,
			-m.c3x, -m.c3y, -m.c3z, -m.c3w
		);
	}

	// @:op(++a)
	// static inline function prefixIncrement(m: Float4x4) {
	// 	var _m: Float4x4Data = m;
	// 	++_m.c0; ++_m.c1; ++_m.c2; ++_m.c3;
	// 	return m.clone();
	// }

	// @:op(--a)
	// static inline function prefixDecrement(m: Float4x4) {
	// 	var _m: Float4x4Data = m;
	// 	--_m.c0; --_m.c1; --_m.c2; --_m.c3;
	// 	return m.clone();
	// }

	// @:op(a++)
	// static inline function postfixIncrement(m: Float4x4) {
	// 	var ret = m.clone();
	// 	var m: Float4x4Data = m;
	// 	++m.c0; ++m.c1; ++m.c2; ++m.c3;
	// 	return ret;
	// }

	// @:op(a--)
	// static inline function postfixDecrement(m: Float4x4) {
	// 	var ret = m.clone();
	// 	var m: Float4x4Data = m;
	// 	--m.c0; --m.c1; --m.c2; --m.c3;
	// 	return ret;
	// }

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
			m.c0x + n.c0x, m.c0y + n.c0y, m.c0z + n.c0z, m.c0w + n.c0w,
			m.c1x + n.c1x, m.c1y + n.c1y, m.c1z + n.c1z, m.c1w + n.c1w,
			m.c2x + n.c2x, m.c2y + n.c2y, m.c2z + n.c2z, m.c2w + n.c2w,
			m.c3x + n.c3x, m.c3y + n.c3y, m.c3z + n.c3z, m.c3w + n.c3w
		);
	}

	@:op(a + b) @:commutative
	static inline function addScalar(m: Float4x4, f: Float): Float4x4 {
		var m: Float4x4Data = m;
		return new Float4x4(
			m.c0x + f, m.c0y + f, m.c0z + f, m.c0w + f,
			m.c1x + f, m.c1y + f, m.c1z + f, m.c1w + f,
			m.c2x + f, m.c2y + f, m.c2z + f, m.c2w + f,
			m.c3x + f, m.c3y + f, m.c3z + f, m.c3w + f
		);
	}

	@:op(a - b)
	static inline function sub(m: Float4x4, n: Float4x4): Float4x4 {
		var m: Float4x4Data = m;
		var n: Float4x4Data = n;
		return new Float4x4(
			m.c0x - n.c0x, m.c0y - n.c0y, m.c0z - n.c0z, m.c0w - n.c0w,
			m.c1x - n.c1x, m.c1y - n.c1y, m.c1z - n.c1z, m.c1w - n.c1w,
			m.c2x - n.c2x, m.c2y - n.c2y, m.c2z - n.c2z, m.c2w - n.c2w,
			m.c3x - n.c3x, m.c3y - n.c3y, m.c3z - n.c3z, m.c3w - n.c3w
		);
	}

	@:op(a - b)
	static inline function subScalar(m: Float4x4, f: Float): Float4x4 {
		var m: Float4x4Data = m;
		return new Float4x4(
			m.c0x - f, m.c0y - f, m.c0z - f, m.c0w - f,
			m.c1x - f, m.c1y - f, m.c1z - f, m.c1w - f,
			m.c2x - f, m.c2y - f, m.c2z - f, m.c2w - f,
			m.c3x - f, m.c3y - f, m.c3z - f, m.c3w - f
		);
	}

	@:op(a - b)
	static inline function subScalarInv(f: Float, m: Float4x4): Float4x4 {
		var m: Float4x4Data = m;
		return new Float4x4(
			f - m.c0x, f - m.c0y, f - m.c0z, f - m.c0w,
			f - m.c1x, f - m.c1y, f - m.c1z, f - m.c1w,
			f - m.c2x, f - m.c2y, f - m.c2z, f - m.c2w,
			f - m.c3x, f - m.c3y, f - m.c3z, f - m.c3w
		);
	}

	

	@:op(a * b)
	static inline function mul(m: Float4x4, n: Float4x4): Float4x4 {
		var m: Float4x4Data = m;
		var n: Float4x4Data = n;
		return new Float4x4(
			m.c0x * n.c0x + m.c1x * n.c0y + m.c2x * n.c0z + m.c3x * n.c0w,
			m.c0y * n.c0x + m.c1y * n.c0y + m.c2y * n.c0z + m.c3y * n.c0w,
			m.c0z * n.c0x + m.c1z * n.c0y + m.c2z * n.c0z + m.c3z * n.c0w,
			m.c0w * n.c0x + m.c1w * n.c0y + m.c2w * n.c0z + m.c3w * n.c0w,
			m.c0x * n.c1x + m.c1x * n.c1y + m.c2x * n.c1z + m.c3x * n.c1w,
			m.c0y * n.c1x + m.c1y * n.c1y + m.c2y * n.c1z + m.c3y * n.c1w,
			m.c0z * n.c1x + m.c1z * n.c1y + m.c2z * n.c1z + m.c3z * n.c1w,
			m.c0w * n.c1x + m.c1w * n.c1y + m.c2w * n.c1z + m.c3w * n.c1w,
			m.c0x * n.c2x + m.c1x * n.c2y + m.c2x * n.c2z + m.c3x * n.c2w,
			m.c0y * n.c2x + m.c1y * n.c2y + m.c2y * n.c2z + m.c3y * n.c2w,
			m.c0z * n.c2x + m.c1z * n.c2y + m.c2z * n.c2z + m.c3z * n.c2w,
			m.c0w * n.c2x + m.c1w * n.c2y + m.c2w * n.c2z + m.c3w * n.c2w,
			m.c0x * n.c3x + m.c1x * n.c3y + m.c2x * n.c3z + m.c3x * n.c3w,
			m.c0y * n.c3x + m.c1y * n.c3y + m.c2y * n.c3z + m.c3y * n.c3w,
			m.c0z * n.c3x + m.c1z * n.c3y + m.c2z * n.c3z + m.c3z * n.c3w,
			m.c0w * n.c3x + m.c1w * n.c3y + m.c2w * n.c3z + m.c3w * n.c3w
		);
	}
	
	@:op(a * b)
	static inline function postMulFloat4(m: Float4x4, v: Float4): Float4 {
		var m: Float4x4Data = m;
		return new Float4(
			m.c0x * v.x + m.c1x * v.y + m.c2x * v.z + m.c3x * v.w,
			m.c0y * v.x + m.c1y * v.y + m.c2y * v.z + m.c3y * v.w,
			m.c0z * v.x + m.c1z * v.y + m.c2z * v.z + m.c3z * v.w,
			m.c0w * v.x + m.c1w * v.y + m.c2w * v.z + m.c3w * v.w
		);
	}

	@:op(a * b)
	static inline function preMulFloat4(v: Float4, m: Float4x4): Float4 {
		var m: Float4x4Data = m;
		return new Float4(
			v.x * m.c0x + v.y * m.c0y + v.z * m.c0z + v.w * m.c0w, 
			v.x * m.c1x + v.y * m.c1y + v.z * m.c1z + v.w * m.c1w,
			v.x * m.c2x + v.y * m.c2y + v.z * m.c2z + v.w * m.c2w,
			v.x * m.c3x + v.y * m.c3y + v.z * m.c3z + v.w * m.c3w
			// v.dot(m.c0),
			// v.dot(m.c1),
			// v.dot(m.c2),
			// v.dot(m.c3)
		);
	}

	@:op(a * b) @:commutative
	static inline function mulScalar(m: Float4x4, f: Float): Float4x4 {
		var m: Float4x4Data = m;
		return new Float4x4(
			m.c0x * f, m.c0y * f, m.c0z * f, m.c0w * f,
			m.c1x * f, m.c1y * f, m.c1z * f, m.c1w * f,
			m.c2x * f, m.c2y * f, m.c2z * f, m.c2w * f,
			m.c3x * f, m.c3y * f, m.c3z * f, m.c3w * f
		);
	}

	@:op(a / b)
	static inline function div(m: Float4x4, n: Float4x4): Float4x4
		return m.matrixCompMult(1.0 / n);

	@:op(a / b)
	static inline function divScalar(m: Float4x4, f: Float): Float4x4 {
		var m: Float4x4Data = m;
		return new Float4x4(
			m.c0x / f, m.c0y / f, m.c0z / f, m.c0w / f,
			m.c1x / f, m.c1y / f, m.c1z / f, m.c1w / f,
			m.c2x / f, m.c2y / f, m.c2z / f, m.c2w / f,
			m.c3x / f, m.c3y / f, m.c3z / f, m.c3w / f
		);
	}

	@:op(a / b)
	static inline function divScalarInv(f: Float, m: Float4x4): Float4x4 {
		var m: Float4x4Data = m;
		return new Float4x4(
			f / m.c0x, f / m.c0y, f / m.c0z, f / m.c0w,
			f / m.c1x, f / m.c1y, f / m.c1z, f / m.c1w,
			f / m.c2x, f / m.c2y, f / m.c2z, f / m.c2w,
			f / m.c3x, f / m.c3y, f / m.c3z, f / m.c3w
		);
	}

	@:op(a == b)
	static inline function equal(m: Float4x4, n: Float4x4): Bool {
		var m: Float4x4Data = m;
		var n: Float4x4Data = n;
		return 
			m.c0x == n.c0x && m.c0y == n.c0y && m.c0z == n.c0z && m.c0w == n.c0w &&
			m.c1x == n.c1x && m.c1y == n.c1y && m.c1z == n.c1z && m.c1w == n.c1w &&
			m.c2x == n.c2x && m.c2y == n.c2y && m.c2z == n.c2z && m.c2w == n.c2w &&
			m.c3x == n.c3x && m.c3y == n.c3y && m.c3z == n.c3z && m.c3w == n.c3w;
	}

	@:op(a != b)
	static inline function notEqual(m: Float4x4, n: Float4x4): Bool
		return !equal(m, n);


	// Rotation is in radians euler angles
	public static function makeSRT( scale: Float3, rotation: Float3, translation: Float3 ): Float4x4 {
		var scaleX = scale.x;
		var scaleY = scale.y;
		var scaleZ = scale.z;
		var cosx = Math.cos(rotation.x);
		var cosy = Math.cos(rotation.y);
		var cosz = Math.cos(rotation.z);
		var sinx = Math.sin(rotation.x);
		var siny = Math.sin(rotation.y);
		var sinz = Math.sin(rotation.z);
		return new Float4x4(
			cosz * cosy * scaleX, sinz * cosy * scaleX, -siny * scaleX, 0, // column1
			(cosz * siny * sinx - sinz * cosx) * scaleY, (sinz * siny * sinx + cosz * cosx) * scaleY, cosy * sinx * scaleY, 0, // column2
			(cosz * siny * cosx + sinz * sinx) * scaleZ, (sinz * siny * cosx - cosz * sinx) * scaleZ, cosy * cosx * scaleZ, 0, // column3
			translation.x, translation.y, translation.z, 1 // column4
		);
	}
	static inline final SIGNIFICANCE = 1e6;
	
	public inline function getTranslation() {
		var x = Math.fround(this.c3x * SIGNIFICANCE) / SIGNIFICANCE;
		var y = Math.fround(this.c3y * SIGNIFICANCE) / SIGNIFICANCE;
		var z = Math.fround(this.c3z * SIGNIFICANCE) / SIGNIFICANCE;
		
		return new Float3(x, y, z);
	}

	public inline function getScale() {
		// Extract the scale by calculating the length of each basis vector
		var x = new Float3(this.c0x, this.c0y, this.c0z).length();
		var y = new Float3(this.c1x, this.c1y, this.c1z).length();
		var z = new Float3(this.c2x, this.c2y, this.c2z).length();

		// Compute the determinant to check for negative scaling
		var determinant = this.c0x * (this.c1y * this.c2z - this.c1z * this.c2y) -
						this.c0y * (this.c1x * this.c2z - this.c1z * this.c2x) +
						this.c0z * (this.c1x * this.c2y - this.c1y * this.c2x);

		// If the determinant is negative, negate one of the scale components
		if (determinant < 0) {
			x = -x;
		}

		x = Math.fround(x * SIGNIFICANCE) / SIGNIFICANCE;
		y = Math.fround(y * SIGNIFICANCE) / SIGNIFICANCE;
		z = Math.fround(z * SIGNIFICANCE) / SIGNIFICANCE;

		return new Float3(x, y, z);
	}

	public inline function getRotationXYZ( scale : Float3 = null) {
		if (scale == null) scale = getScale();

		var scaledc1z = this.c1z / scale.y;
		var scaledc2z = this.c2z / scale.z;

		var x = Math.atan2(scaledc1z, this.c2z / scale.z);  
        var y = Math.atan2(-this.c0z / scale.x, Math.sqrt(scaledc1z * scaledc1z + scaledc2z * scaledc2z));
        var z = Math.atan2(this.c0y / scale.x, this.c0x / scale.x);

		x = Math.fround(x * SIGNIFICANCE) / SIGNIFICANCE;
		y = Math.fround(y * SIGNIFICANCE) / SIGNIFICANCE;
		z = Math.fround(z * SIGNIFICANCE) / SIGNIFICANCE;
		
		return new Float3(x, y, z);
	}

	public inline static function makeIdentity() {
		return identity.clone();
	}
	
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
	
	public var c0x: Float;
	public var c0y: Float;
	public var c0z: Float;
	public var c0w: Float;
	public var c1x: Float;
	public var c1y: Float;
	public var c1z: Float;
	public var c1w: Float;
	public var c2x: Float;
	public var c2y: Float;
	public var c2z: Float;
	public var c2w: Float;
	public var c3x: Float;
	public var c3y: Float;
	public var c3z: Float;
	public var c3w: Float;

	public inline function new(
			a00: Float, a01: Float, a02: Float, a03: Float, // column 0
			a10: Float, a11: Float, a12: Float, a13: Float, // column 1
			a20: Float, a21: Float, a22: Float, a23: Float, // column 2
			a30: Float, a31: Float, a32: Float, a33: Float // column 3
		) {
		c0x = a00; c0y = a01; c0z = a02; c0w = a03;
		c1x = a10; c1y = a11; c1z = a12; c1w = a13;
		c2x = a20; c2y = a21; c2z = a22; c2w = a23;
		c3x = a30; c3y = a31; c3z = a32; c3w = a33;
		}
	#end
}
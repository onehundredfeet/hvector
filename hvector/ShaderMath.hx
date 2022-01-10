package hvector;
/**
	# Vector Mathematics Library

	Enables GLSL vector and matrix operations to compile in haxe

	Reference Spec GLSL ES 1.0: https://www.khronos.org/files/opengles_shading_language.pdf

	**Usage**:
	Add `import ShaderMath;` to be able to use GLSL functions and constructors

	@license MIT
	@author haxiomic (George Corney)
	@author onehundredfeet (Ryan Cleven)
**/

// # Built-in Functions

// trigonometric

#if (vector_math_f32 && (cpp || hl || cs || java))
// override Single (usually f64) type with f32
//@:eager private typedef Single = Single;
#end

overload extern inline function radians(degrees: Vec4): Vec4 return degrees.radians();
overload extern inline function radians(degrees: Vec3): Vec3 return degrees.radians();
overload extern inline function radians(degrees: Vec2): Vec2 return degrees.radians();
overload extern inline function radians(degrees: Single): Single return degrees * Constants.PI / 180;

overload extern inline function degrees(radians: Vec4): Vec4 return radians.degrees();
overload extern inline function degrees(radians: Vec3): Vec3 return radians.degrees();
overload extern inline function degrees(radians: Vec2): Vec2 return radians.degrees();
overload extern inline function degrees(radians: Single): Single return radians * 180 / Constants.PI;

overload extern inline function sin(v: Vec4): Vec4 return v.sin();
overload extern inline function sin(v: Vec3): Vec3 return v.sin();
overload extern inline function sin(v: Vec2): Vec2 return v.sin();
overload extern inline function sin(v: Single): Single return Math.sin(v);

overload extern inline function cos(v: Vec4): Vec4 return v.cos();
overload extern inline function cos(v: Vec3): Vec3 return v.cos();
overload extern inline function cos(v: Vec2): Vec2 return v.cos();
overload extern inline function cos(v: Single): Single return Math.cos(v);

overload extern inline function tan(v: Vec4): Vec4 return v.tan();
overload extern inline function tan(v: Vec3): Vec3 return v.tan();
overload extern inline function tan(v: Vec2): Vec2 return v.tan();
overload extern inline function tan(v: Single): Single return Math.tan(v);

overload extern inline function asin(v: Vec4): Vec4 return v.asin();
overload extern inline function asin(v: Vec3): Vec3 return v.asin();
overload extern inline function asin(v: Vec2): Vec2 return v.asin();
overload extern inline function asin(v: Single): Single return Math.asin(v);

overload extern inline function acos(v: Vec4): Vec4 return v.acos();
overload extern inline function acos(v: Vec3): Vec3 return v.acos();
overload extern inline function acos(v: Vec2): Vec2 return v.acos();
overload extern inline function acos(v: Single): Single return Math.acos(v);

overload extern inline function atan(v: Vec4): Vec4 return v.atan();
overload extern inline function atan(v: Vec3): Vec3 return v.atan();
overload extern inline function atan(v: Vec2): Vec2 return v.atan();
overload extern inline function atan(v: Single): Single return Math.atan(v);

overload extern inline function atan2(v: Vec4, b: Vec4): Vec4 return v.atan2(b);
overload extern inline function atan2(v: Vec3, b: Vec3): Vec3 return v.atan2(b);
overload extern inline function atan2(v: Vec2, b: Vec2): Vec2 return v.atan2(b);
overload extern inline function atan2(v: Single, b: Single): Single return Math.atan2(v, b);

// exponential

overload extern inline function pow(v: Vec4, e: Vec4): Vec4 return v.pow(e);
overload extern inline function pow(v: Vec3, e: Vec3): Vec3 return v.pow(e);
overload extern inline function pow(v: Vec2, e: Vec2): Vec2 return v.pow(e);
overload extern inline function pow(v: Single, e: Single): Single return Math.pow(v, e);

overload extern inline function exp(v: Vec4): Vec4 return v.exp();
overload extern inline function exp(v: Vec3): Vec3 return v.exp();
overload extern inline function exp(v: Vec2): Vec2 return v.exp();
overload extern inline function exp(v: Single): Single return Math.exp(v);

overload extern inline function log(v: Vec4): Vec4 return v.log();
overload extern inline function log(v: Vec3): Vec3 return v.log();
overload extern inline function log(v: Vec2): Vec2 return v.log();
overload extern inline function log(v: Single): Single return Math.log(v);

overload extern inline function exp2(v: Vec4): Vec4 return v.exp2();
overload extern inline function exp2(v: Vec3): Vec3 return v.exp2();
overload extern inline function exp2(v: Vec2): Vec2 return v.exp2();
overload extern inline function exp2(v: Single): Single return Math.pow(2, v);

overload extern inline function log2(v: Vec4): Vec4 return v.log2();
overload extern inline function log2(v: Vec3): Vec3 return v.log2();
overload extern inline function log2(v: Vec2): Vec2 return v.log2();
overload extern inline function log2(v: Single): Single return log2f(v);

overload extern inline function sqrt(v: Vec4): Vec4 return v.sqrt();
overload extern inline function sqrt(v: Vec3): Vec3 return v.sqrt();
overload extern inline function sqrt(v: Vec2): Vec2 return v.sqrt();
overload extern inline function sqrt(v: Single): Single return Math.sqrt(v);

overload extern inline function inverseSqrt(v: Vec4): Vec4 return v.inverseSqrt();
overload extern inline function inverseSqrt(v: Vec3): Vec3 return v.inverseSqrt();
overload extern inline function inverseSqrt(v: Vec2): Vec2 return v.inverseSqrt();
overload extern inline function inverseSqrt(v: Single): Single return 1.0 / Math.sqrt(v);

// common

overload extern inline function abs(v: Vec4): Vec4 return v.abs();
overload extern inline function abs(v: Vec3): Vec3 return v.abs();
overload extern inline function abs(v: Vec2): Vec2 return v.abs();
overload extern inline function abs(v: Single): Single return Math.abs(v);

overload extern inline function sign(v: Vec4): Vec4 return v.sign();
overload extern inline function sign(v: Vec3): Vec3 return v.sign();
overload extern inline function sign(v: Vec2): Vec2 return v.sign();
overload extern inline function sign(v: Single): Single return v > 0. ? 1. : (v < 0. ? -1. : 0.);

overload extern inline function floor(v: Vec4): Vec4 return v.floor();
overload extern inline function floor(v: Vec3): Vec3 return v.floor();
overload extern inline function floor(v: Vec2): Vec2 return v.floor();
overload extern inline function floor(v: Single): Int return Math.floor(v);

overload extern inline function ceil(v: Vec4): Vec4 return v.ceil();
overload extern inline function ceil(v: Vec3): Vec3 return v.ceil();
overload extern inline function ceil(v: Vec2): Vec2 return v.ceil();
overload extern inline function ceil(v: Single): Int return Math.ceil(v);

overload extern inline function fract(v: Vec4): Vec4 return v.fract();
overload extern inline function fract(v: Vec3): Vec3 return v.fract();
overload extern inline function fract(v: Vec2): Vec2 return v.fract();
overload extern inline function fract(v: Single): Single return v - Math.floor(v);

overload extern inline function mod(v: Vec4, d: Single): Vec4 return v.mod(d);
overload extern inline function mod(v: Vec4, d: Vec4): Vec4 return v.mod(d);
overload extern inline function mod(v: Vec3, d: Single): Vec3 return v.mod(d);
overload extern inline function mod(v: Vec3, d: Vec3): Vec3 return v.mod(d);
overload extern inline function mod(v: Vec2, d: Single): Vec2 return v.mod(d);
overload extern inline function mod(v: Vec2, d: Vec2): Vec2 return v.mod(d);
overload extern inline function mod(v: Single, d: Single): Single return v - d * Math.floor(v / d);

overload extern inline function min(v: Vec4, b: Single): Vec4 return v.min(b);
overload extern inline function min(v: Vec4, b: Vec4): Vec4 return v.min(b);
overload extern inline function min(v: Vec3, b: Single): Vec3 return v.min(b);
overload extern inline function min(v: Vec3, b: Vec3): Vec3 return v.min(b);
overload extern inline function min(v: Vec2, b: Single): Vec2 return v.min(b);
overload extern inline function min(v: Vec2, b: Vec2): Vec2 return v.min(b);
overload extern inline function min(v: Single, b: Single): Single return MathExt.min(v, b);

overload extern inline function max(v: Vec4, b: Single): Vec4 return v.max(b);
overload extern inline function max(v: Vec4, b: Vec4): Vec4 return v.max(b);
overload extern inline function max(v: Vec3, b: Single): Vec3 return v.max(b);
overload extern inline function max(v: Vec3, b: Vec3): Vec3 return v.max(b);
overload extern inline function max(v: Vec2, b: Single): Vec2 return v.max(b);
overload extern inline function max(v: Vec2, b: Vec2): Vec2 return v.max(b);
overload extern inline function max(v: Single, b: Single): Single return MathExt.max(v, b);

overload extern inline function clamp(v: Vec4, min: Single, max: Single): Vec4 return v.clamp(min, max);
overload extern inline function clamp(v: Vec4, min: Vec4, max: Vec4): Vec4 return v.clamp(min, max);
overload extern inline function clamp(v: Vec3, min: Single, max: Single): Vec3 return v.clamp(min, max);
overload extern inline function clamp(v: Vec3, min: Vec3, max: Vec3): Vec3 return v.clamp(min, max);
overload extern inline function clamp(v: Vec2, min: Single, max: Single): Vec2 return v.clamp(min, max);
overload extern inline function clamp(v: Vec2, min: Vec2, max: Vec2): Vec2 return v.clamp(min, max);
overload extern inline function clamp(v: Single, min: Single, max: Single): Single return v < min ? min : (v > max ? max : v);

overload extern inline function mix(a: Vec4, b: Vec4, t: Single): Vec4 return a.mix(b, t);
overload extern inline function mix(a: Vec4, b: Vec4, t: Vec4): Vec4 return a.mix(b, t);
overload extern inline function mix(a: Vec3, b: Vec3, t: Single): Vec3 return a.mix(b, t);
overload extern inline function mix(a: Vec3, b: Vec3, t: Vec3): Vec3 return a.mix(b, t);
overload extern inline function mix(a: Vec2, b: Vec2, t: Single): Vec2 return a.mix(b, t);
overload extern inline function mix(a: Vec2, b: Vec2, t: Vec2): Vec2 return a.mix(b, t);
overload extern inline function mix(a: Single, b: Single, t: Single): Single return a * (1.0 - t) + b * t;

overload extern inline function step(edge: Single, v: Vec4): Vec4 return v.step(edge);
overload extern inline function step(edge: Vec4, v: Vec4): Vec4 return v.step(edge);
overload extern inline function step(edge: Single, v: Vec3): Vec3 return v.step(edge);
overload extern inline function step(edge: Vec3, v: Vec3): Vec3 return v.step(edge);
overload extern inline function step(edge: Single, v: Vec2): Vec2 return v.step(edge);
overload extern inline function step(edge: Vec2, v: Vec2): Vec2 return v.step(edge);
overload extern inline function step(edge: Single, v: Single): Single return v < edge ? 0.0 : 1.0;

overload extern inline function smoothstep(edge0: Single, edge1: Single, v: Vec4): Vec4 return v.smoothstep(edge0, edge1);
overload extern inline function smoothstep(edge0: Vec4, edge1: Vec4, v: Vec4): Vec4 return v.smoothstep(edge0, edge1);
overload extern inline function smoothstep(edge0: Single, edge1: Single, v: Vec3): Vec3 return v.smoothstep(edge0, edge1);
overload extern inline function smoothstep(edge0: Vec3, edge1: Vec3, v: Vec3): Vec3 return v.smoothstep(edge0, edge1);
overload extern inline function smoothstep(edge0: Single, edge1: Single, v: Vec2): Vec2 return v.smoothstep(edge0, edge1);
overload extern inline function smoothstep(edge0: Vec2, edge1: Vec2, v: Vec2): Vec2 return v.smoothstep(edge0, edge1);
overload extern inline function smoothstep(edge0: Single, edge1: Single, v: Single): Single {
	var t = (v - edge0) / (edge1 - edge0);
	t = t < 0. ? 0. : (t > 1. ? 1. : t); // clamp to 0, 1
	return t * t * (3.0 - 2.0 * t);
}

// geometric

overload extern inline function length(v: Vec4): Single return v.length();
overload extern inline function length(v: Vec3): Single return v.length();
overload extern inline function length(v: Vec2): Single return v.length();
overload extern inline function length(v: Single): Single return Math.abs(v);

overload extern inline function distance(v: Vec4, b: Vec4): Single return v.distance(b);
overload extern inline function distance(v: Vec3, b: Vec3): Single return v.distance(b);
overload extern inline function distance(v: Vec2, b: Vec2): Single return v.distance(b);
overload extern inline function distance(v: Single, b: Single): Single return Math.abs(v - b);

overload extern inline function dot(v: Vec4, b: Vec4): Single return v.dot(b);
overload extern inline function dot(v: Vec3, b: Vec3): Single return v.dot(b);
overload extern inline function dot(v: Vec2, b: Vec2): Single return v.dot(b);
overload extern inline function dot(v: Single, b: Single): Single return (v * b);

overload extern inline function normalize(v: Vec4): Vec4 return v.normalize();
overload extern inline function normalize(v: Vec3): Vec3 return v.normalize();
overload extern inline function normalize(v: Vec2): Vec2 return v.normalize();
overload extern inline function normalize(v: Single) return v <= 0.0 ? 0.0 : 1.0;

overload extern inline function faceforward(v: Vec4, I: Vec4, Nref: Vec4): Vec4 return v.faceforward(I, Nref);
overload extern inline function faceforward(v: Vec3, I: Vec3, Nref: Vec3): Vec3 return v.faceforward(I, Nref);
overload extern inline function faceforward(v: Vec2, I: Vec2, Nref: Vec2): Vec2 return v.faceforward(I, Nref);
overload extern inline function faceforward(v: Single, I: Single, Nref: Single): Single return (I * Nref < 0 ? v : -v);

overload extern inline function reflect(I: Vec4, N: Vec4): Vec4 return I.reflect(N);
overload extern inline function reflect(I: Vec3, N: Vec3): Vec3 return I.reflect(N);
overload extern inline function reflect(I: Vec2, N: Vec2): Vec2 return I.reflect(N);
overload extern inline function reflect(I: Single, N: Single): Single return I - 2 * (N * I) * N;

overload extern inline function refract(I: Vec4, N: Vec4, eta: Single): Vec4 return I.refract(N, eta);
overload extern inline function refract(I: Vec3, N: Vec3, eta: Single): Vec3 return I.refract(N, eta);
overload extern inline function refract(I: Vec2, N: Vec2, eta: Single): Vec2 return I.refract(N, eta);
overload extern inline function refract(I: Single, N: Single, eta: Single): Single {
	var nDotI = I * N;
	var k = 1.0 - eta * eta * (1.0 - nDotI * nDotI);
	return if (k < 0.0) {
		0.0;
	} else {
		eta * I - (eta * nDotI + Math.sqrt(k)) * N;
	}
}

overload extern inline function matrixCompMult(m: Mat4, n: Mat4): Mat4 return m.matrixCompMult(n);
overload extern inline function matrixCompMult(m: Mat3, n: Mat3): Mat3 return m.matrixCompMult(n);
overload extern inline function matrixCompMult(m: Mat2, n: Mat2): Mat2 return m.matrixCompMult(n);

// extended methods beyond GLSL ES 100
overload extern inline function transpose(m: Mat4): Mat4 return m.transpose();
overload extern inline function transpose(m: Mat3): Mat3 return m.transpose();
overload extern inline function transpose(m: Mat2): Mat2 return m.transpose();

overload extern inline function determinant(m: Mat4): Single return m.determinant();
overload extern inline function determinant(m: Mat3): Single return m.determinant();
overload extern inline function determinant(m: Mat2): Single return m.determinant();

overload extern inline function inverse(m: Mat4): Mat4 return m.inverse();
overload extern inline function inverse(m: Mat3): Mat3 return m.inverse();
overload extern inline function inverse(m: Mat2): Mat2 return m.inverse();

overload extern inline function adjoint(m: Mat4): Mat4 return m.adjoint();
overload extern inline function adjoint(m: Mat3): Mat3 return m.adjoint();
overload extern inline function adjoint(m: Mat2): Mat2 return m.adjoint();

// special-case functions

overload extern inline function cross(a: Vec3, b: Vec3): Vec3 {
	return a.cross(b);
}
// # Vector Initializers

overload extern inline function vec2(m: Mat4): Vec2 return new Vec2(m[0][0], m[0][1]);
overload extern inline function vec2(m: Mat3): Vec2 return new Vec2(m[0][0], m[0][1]);
overload extern inline function vec2(m: Mat2): Vec2 return new Vec2(m[0][0], m[0][1]);
overload extern inline function vec2(xyzw: Vec4): Vec2 return new Vec2(xyzw.x, xyzw.y);
overload extern inline function vec2(xyz: Vec3): Vec2 return new Vec2(xyz.x, xyz.y);
overload extern inline function vec2(xy: Vec2): Vec2 return new Vec2(xy.x, xy.y);
overload extern inline function vec2(x: Single): Vec2 return new Vec2(x, x);
overload extern inline function vec2(x: Single, y: Single): Vec2 return new Vec2(x, y);

overload extern inline function vec3(m: Mat4): Vec3 return new Vec3(m[0][0], m[0][1], m[0][2]);
overload extern inline function vec3(m: Mat3): Vec3 return new Vec3(m[0][0], m[0][1], m[0][2]);
overload extern inline function vec3(m: Mat2): Vec3 return new Vec3(m[0][0], m[0][1], m[1][0]);
overload extern inline function vec3(xyzw: Vec4): Vec3 return new Vec3(xyzw.x, xyzw.y, xyzw.z);
overload extern inline function vec3(xyz: Vec3): Vec3 return new Vec3(xyz.x, xyz.y, xyz.z);
overload extern inline function vec3(x: Single, yz: Vec2): Vec3 return new Vec3(x, yz.x, yz.y);
overload extern inline function vec3(xy: Vec2, z: Single): Vec3 return new Vec3(xy.x, xy.y, z);
overload extern inline function vec3(x: Single): Vec3 return new Vec3(x, x, x);
overload extern inline function vec3(x: Single, y: Single, z: Single): Vec3 return new Vec3(x, y, z);

overload extern inline function vec4(m: Mat4): Vec4 return new Vec4(m[0][0], m[0][1], m[0][2], m[0][3]);
overload extern inline function vec4(m: Mat3): Vec4 return new Vec4(m[0][0], m[0][1], m[0][2], m[1][0]);
overload extern inline function vec4(m: Mat2): Vec4 return new Vec4(m[0][0], m[0][1], m[1][0], m[1][1]);
overload extern inline function vec4(xyzw: Vec4): Vec4 return new Vec4(xyzw.x, xyzw.y, xyzw.z, xyzw.w);
overload extern inline function vec4(x: Single, yzw: Vec3): Vec4 return new Vec4(x, yzw.x, yzw.y, yzw.z);
overload extern inline function vec4(xyz: Vec3, w: Single): Vec4 return new Vec4(xyz.x, xyz.y, xyz.z, w);
overload extern inline function vec4(xy: Vec2, zw: Vec2): Vec4 return new Vec4(xy.x, xy.y, zw.x, zw.y);
overload extern inline function vec4(x: Single, y: Single, zw: Vec2): Vec4 return new Vec4(x, y, zw.x, zw.y);
overload extern inline function vec4(x: Single, yz: Vec2, w: Single): Vec4 return new Vec4(x, yz.x, yz.y, w);
overload extern inline function vec4(xy: Vec2, z: Single, w: Single): Vec4 return new Vec4(xy.x, xy.y, z, w);
overload extern inline function vec4(x: Single): Vec4 return new Vec4(x, x, x, x);
overload extern inline function vec4(x: Single, y: Single, z: Single, w: Single): Vec4 return new Vec4(x, y, z, w);

overload extern inline function mat2(m: Mat4): Mat2 return new Mat2(m[0][0], m[0][1], m[1][0], m[1][1]);
overload extern inline function mat2(m: Mat3): Mat2 return new Mat2(m[0][0], m[0][1], m[1][0], m[1][1]);
overload extern inline function mat2(m: Mat2): Mat2 return m.clone();
overload extern inline function mat2(v: Vec4): Mat2 return new Mat2(v.x, v.y, v.z, v.w);
overload extern inline function mat2(column0: Vec2, column1: Vec2): Mat2 return new Mat2(column0.x, column0.y, column1.x, column1.y);
overload extern inline function mat2(scale: Single): Mat2 return new Mat2(scale, 0.0, 0.0, scale);
overload extern inline function mat2(a00: Single, a01: Single, a10: Single, a11: Single): Mat2 return new Mat2(a00, a01, a10, a11);

overload extern inline function mat3(m: Mat4): Mat3 return new Mat3(
	m[0][0], m[0][1], m[0][2],
	m[1][0], m[1][1], m[1][2],
	m[2][0], m[2][1], m[2][2]
);
overload extern inline function mat3(m: Mat3): Mat3 return m.clone();
overload extern inline function mat3(m: Mat2): Mat3 return new Mat3(
	m[0][0], m[0][1], 0.0,
	m[1][0], m[1][1], 0.0,
	0.0, 0.0, 1.0
);
overload extern inline function mat3(column0: Vec3, column1: Vec3, column2: Vec3): Mat3 return new Mat3(
	column0.x, column0.y, column0.z,
	column1.x, column1.y, column1.z,
	column2.x, column2.y, column2.z
);
overload extern inline function mat3(scale: Single): Mat3 return new Mat3(
	scale, 0.0, 0.0,
	0.0, scale, 0.0,
	0.0, 0.0, scale
);
overload extern inline function mat3(
	a00: Single, a01: Single, a02: Single,
	a10: Single, a11: Single, a12: Single,
	a20: Single, a21: Single, a22: Single
): Mat3 return new Mat3(
	a00, a01, a02,
	a10, a11, a12,
	a20, a21, a22
);

overload extern inline function mat4(m: Mat4): Mat4 return m.clone();
overload extern inline function mat4(m: Mat3): Mat4 return new Mat4(
	m[0][0], m[0][1], m[0][2], 0.0,
	m[1][0], m[1][1], m[1][2], 0.0,
	m[2][0], m[2][1], m[2][2], 0.0,
	0.0, 0.0, 0.0, 1.0
);
overload extern inline function mat4(m: Mat2): Mat4 return new Mat4(
	m[0][0], m[0][1], 0.0, 0.0,
	m[1][0], m[1][1], 0.0, 0.0,
	0.0, 0.0, 1.0, 0.0,
	0.0, 0.0, 0.0, 1.0
);
overload extern inline function mat4(column0: Vec4, column1: Vec4, column2: Vec4, column3: Vec4): Mat4 return new Mat4(
	column0.x, column0.y, column0.z, column0.w,
	column1.x, column1.y, column1.z, column1.w,
	column2.x, column2.y, column2.z, column2.w,
	column3.x, column3.y, column3.z, column3.w
);
overload extern inline function mat4(scale: Single): Mat4 return new Mat4(
	scale, 0.0, 0.0, 0.0,
	0.0, scale, 0.0, 0.0,
	0.0, 0.0, scale, 0.0,
	0.0, 0.0, 0.0, scale
);
overload extern inline function mat4(
	a00: Single, a01: Single, a02: Single, a03: Single,
	a10: Single, a11: Single, a12: Single, a13: Single,
	a20: Single, a21: Single, a22: Single, a23: Single,
	a30: Single, a31: Single, a32: Single, a33: Single
): Mat4 return new Mat4(
	a00, a01, a02, a03,
	a10, a11, a12, a13,
	a20, a21, a22, a23,
	a30, a31, a32, a33
);

// internal methods
private inline function log2f(v: Single) {
	var l2 = Math.log(v) * 1.4426950408889634;

	// we must handle powers of 2 exactly to avoid unexpected behavior Singleing point values, e.g. log2(8) ~ 2.9999... which may later be used in floor()
	var isPot = if (v % 1 == 0) {
		// is integer
		var i = Std.int(v);
		(i & (i - 1)) == 0; // is power of 2
	} else false;

	return isPot ? Math.round(l2) : l2;
}
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
// override Float (usually f64) type with f32
//@:eager private typedef Float = Float;
#end

#if (js || ucpp_runtime)
import hvector.Single;
#end

overload extern inline function radians(degrees: Float4): Float4 return degrees.radians();
overload extern inline function radians(degrees: Float3): Float3 return degrees.radians();
overload extern inline function radians(degrees: Float2): Float2 return degrees.radians();
overload extern inline function radians(degrees: Float): Float return degrees * Constants.PI / 180;

overload extern inline function degrees(radians: Float4): Float4 return radians.degrees();
overload extern inline function degrees(radians: Float3): Float3 return radians.degrees();
overload extern inline function degrees(radians: Float2): Float2 return radians.degrees();
overload extern inline function degrees(radians: Float): Float return radians * 180 / Constants.PI;

overload extern inline function sin(v: Float4): Float4 return v.sin();
overload extern inline function sin(v: Float3): Float3 return v.sin();
overload extern inline function sin(v: Float2): Float2 return v.sin();
overload extern inline function sin(v: Float): Float return Math.sin(v);

overload extern inline function cos(v: Float4): Float4 return v.cos();
overload extern inline function cos(v: Float3): Float3 return v.cos();
overload extern inline function cos(v: Float2): Float2 return v.cos();
overload extern inline function cos(v: Float): Float return Math.cos(v);

overload extern inline function tan(v: Float4): Float4 return v.tan();
overload extern inline function tan(v: Float3): Float3 return v.tan();
overload extern inline function tan(v: Float2): Float2 return v.tan();
overload extern inline function tan(v: Float): Float return Math.tan(v);

overload extern inline function asin(v: Float4): Float4 return v.asin();
overload extern inline function asin(v: Float3): Float3 return v.asin();
overload extern inline function asin(v: Float2): Float2 return v.asin();
overload extern inline function asin(v: Float): Float return Math.asin(v);

overload extern inline function acos(v: Float4): Float4 return v.acos();
overload extern inline function acos(v: Float3): Float3 return v.acos();
overload extern inline function acos(v: Float2): Float2 return v.acos();
overload extern inline function acos(v: Float): Float return Math.acos(v);

overload extern inline function atan(v: Float4): Float4 return v.atan();
overload extern inline function atan(v: Float3): Float3 return v.atan();
overload extern inline function atan(v: Float2): Float2 return v.atan();
overload extern inline function atan(v: Float): Float return Math.atan(v);

overload extern inline function atan2(v: Float4, b: Float4): Float4 return v.atan2(b);
overload extern inline function atan2(v: Float3, b: Float3): Float3 return v.atan2(b);
overload extern inline function atan2(v: Float2, b: Float2): Float2 return v.atan2(b);
overload extern inline function atan2(v: Float, b: Float): Float return Math.atan2(v, b);

// exponential

overload extern inline function pow(v: Float4, e: Float4): Float4 return v.pow(e);
overload extern inline function pow(v: Float3, e: Float3): Float3 return v.pow(e);
overload extern inline function pow(v: Float2, e: Float2): Float2 return v.pow(e);
overload extern inline function pow(v: Float, e: Float): Float return Math.pow(v, e);

overload extern inline function exp(v: Float4): Float4 return v.exp();
overload extern inline function exp(v: Float3): Float3 return v.exp();
overload extern inline function exp(v: Float2): Float2 return v.exp();
overload extern inline function exp(v: Float): Float return Math.exp(v);

overload extern inline function log(v: Float4): Float4 return v.log();
overload extern inline function log(v: Float3): Float3 return v.log();
overload extern inline function log(v: Float2): Float2 return v.log();
overload extern inline function log(v: Float): Float return Math.log(v);

overload extern inline function exp2(v: Float4): Float4 return v.exp2();
overload extern inline function exp2(v: Float3): Float3 return v.exp2();
overload extern inline function exp2(v: Float2): Float2 return v.exp2();
overload extern inline function exp2(v: Float): Float return Math.pow(2, v);

overload extern inline function log2(v: Float4): Float4 return v.log2();
overload extern inline function log2(v: Float3): Float3 return v.log2();
overload extern inline function log2(v: Float2): Float2 return v.log2();
overload extern inline function log2(v: Float): Float return log2f(v);

overload extern inline function sqrt(v: Float4): Float4 return v.sqrt();
overload extern inline function sqrt(v: Float3): Float3 return v.sqrt();
overload extern inline function sqrt(v: Float2): Float2 return v.sqrt();
overload extern inline function sqrt(v: Float): Float return Math.sqrt(v);

overload extern inline function inverseSqrt(v: Float4): Float4 return v.inverseSqrt();
overload extern inline function inverseSqrt(v: Float3): Float3 return v.inverseSqrt();
overload extern inline function inverseSqrt(v: Float2): Float2 return v.inverseSqrt();
overload extern inline function inverseSqrt(v: Float): Float return 1.0 / Math.sqrt(v);

// common

overload extern inline function abs(v: Float4): Float4 return v.abs();
overload extern inline function abs(v: Float3): Float3 return v.abs();
overload extern inline function abs(v: Float2): Float2 return v.abs();
overload extern inline function abs(v: Float): Float return Math.abs(v);

overload extern inline function sign(v: Float4): Float4 return v.sign();
overload extern inline function sign(v: Float3): Float3 return v.sign();
overload extern inline function sign(v: Float2): Float2 return v.sign();
overload extern inline function sign(v: Float): Float return v > 0. ? 1. : (v < 0. ? -1. : 0.);

overload extern inline function floor(v: Float4): Float4 return v.floor();
overload extern inline function floor(v: Float3): Float3 return v.floor();
overload extern inline function floor(v: Float2): Float2 return v.floor();
overload extern inline function floor(v: Float): Int return Math.floor(v);

overload extern inline function ceil(v: Float4): Float4 return v.ceil();
overload extern inline function ceil(v: Float3): Float3 return v.ceil();
overload extern inline function ceil(v: Float2): Float2 return v.ceil();
overload extern inline function ceil(v: Float): Int return Math.ceil(v);

overload extern inline function fract(v: Float4): Float4 return v.fract();
overload extern inline function fract(v: Float3): Float3 return v.fract();
overload extern inline function fract(v: Float2): Float2 return v.fract();
overload extern inline function fract(v: Float): Float return v - Math.floor(v);

overload extern inline function mod(v: Float4, d: Float): Float4 return v.mod(d);
overload extern inline function mod(v: Float4, d: Float4): Float4 return v.mod(d);
overload extern inline function mod(v: Float3, d: Float): Float3 return v.mod(d);
overload extern inline function mod(v: Float3, d: Float3): Float3 return v.mod(d);
overload extern inline function mod(v: Float2, d: Float): Float2 return v.mod(d);
overload extern inline function mod(v: Float2, d: Float2): Float2 return v.mod(d);
overload extern inline function mod(v: Float, d: Float): Float return v - d * Math.floor(v / d);

overload extern inline function min(v: Float4, b: Float): Float4 return v.min(b);
overload extern inline function min(v: Float4, b: Float4): Float4 return v.min(b);
overload extern inline function min(v: Float3, b: Float): Float3 return v.min(b);
overload extern inline function min(v: Float3, b: Float3): Float3 return v.min(b);
overload extern inline function min(v: Float2, b: Float): Float2 return v.min(b);
overload extern inline function min(v: Float2, b: Float2): Float2 return v.min(b);
overload extern inline function min(v: Float, b: Float): Float return Math.min(v, b);

overload extern inline function max(v: Float4, b: Float): Float4 return v.max(b);
overload extern inline function max(v: Float4, b: Float4): Float4 return v.max(b);
overload extern inline function max(v: Float3, b: Float): Float3 return v.max(b);
overload extern inline function max(v: Float3, b: Float3): Float3 return v.max(b);
overload extern inline function max(v: Float2, b: Float): Float2 return v.max(b);
overload extern inline function max(v: Float2, b: Float2): Float2 return v.max(b);
overload extern inline function max(v: Float, b: Float): Float return Math.max(v, b);

overload extern inline function clamp(v: Float4, min: Float, max: Float): Float4 return v.clamp(min, max);
overload extern inline function clamp(v: Float4, min: Float4, max: Float4): Float4 return v.clamp(min, max);
overload extern inline function clamp(v: Float3, min: Float, max: Float): Float3 return v.clamp(min, max);
overload extern inline function clamp(v: Float3, min: Float3, max: Float3): Float3 return v.clamp(min, max);
overload extern inline function clamp(v: Float2, min: Float, max: Float): Float2 return v.clamp(min, max);
overload extern inline function clamp(v: Float2, min: Float2, max: Float2): Float2 return v.clamp(min, max);
overload extern inline function clamp(v: Float, min: Float, max: Float): Float return v < min ? min : (v > max ? max : v);

overload extern inline function mix(a: Float4, b: Float4, t: Float): Float4 return a.mix(b, t);
overload extern inline function mix(a: Float4, b: Float4, t: Float4): Float4 return a.mix(b, t);
overload extern inline function mix(a: Float3, b: Float3, t: Float): Float3 return a.mix(b, t);
overload extern inline function mix(a: Float3, b: Float3, t: Float3): Float3 return a.mix(b, t);
overload extern inline function mix(a: Float2, b: Float2, t: Float): Float2 return a.mix(b, t);
overload extern inline function mix(a: Float2, b: Float2, t: Float2): Float2 return a.mix(b, t);
overload extern inline function mix(a: Float, b: Float, t: Float): Float return a * (1.0 - t) + b * t;

overload extern inline function step(edge: Float, v: Float4): Float4 return v.step(edge);
overload extern inline function step(edge: Float4, v: Float4): Float4 return v.step(edge);
overload extern inline function step(edge: Float, v: Float3): Float3 return v.step(edge);
overload extern inline function step(edge: Float3, v: Float3): Float3 return v.step(edge);
overload extern inline function step(edge: Float, v: Float2): Float2 return v.step(edge);
overload extern inline function step(edge: Float2, v: Float2): Float2 return v.step(edge);
overload extern inline function step(edge: Float, v: Float): Float return v < edge ? 0.0 : 1.0;

overload extern inline function smoothstep(edge0: Float, edge1: Float, v: Float4): Float4 return v.smoothstep(edge0, edge1);
overload extern inline function smoothstep(edge0: Float4, edge1: Float4, v: Float4): Float4 return v.smoothstep(edge0, edge1);
overload extern inline function smoothstep(edge0: Float, edge1: Float, v: Float3): Float3 return v.smoothstep(edge0, edge1);
overload extern inline function smoothstep(edge0: Float3, edge1: Float3, v: Float3): Float3 return v.smoothstep(edge0, edge1);
overload extern inline function smoothstep(edge0: Float, edge1: Float, v: Float2): Float2 return v.smoothstep(edge0, edge1);
overload extern inline function smoothstep(edge0: Float2, edge1: Float2, v: Float2): Float2 return v.smoothstep(edge0, edge1);
overload extern inline function smoothstep(edge0: Float, edge1: Float, v: Float): Float {
	var t = (v - edge0) / (edge1 - edge0);
	t = t < 0. ? 0. : (t > 1. ? 1. : t); // clamp to 0, 1
	return t * t * (3.0 - 2.0 * t);
}

overload extern inline function lerp(a: Float4, b: Float4, t: Float): Float4 {
	return a * (1.0 - t) + b * t;
}
overload extern inline function lerp(a: Float3, b: Float3, t: Float): Float3 {
	return a * (1.0 - t) + b * t;
}
overload extern inline function lerp(a: Float2, b: Float2, t: Float): Float2 {
	return a * (1.0 - t) + b * t;
}

overload extern inline function lerp(a: Float, b: Float, t: Float): Float {
	return a * (1.0 - t) + b * t;	
}

overload extern inline function length(v: Float4): Float return v.length();
overload extern inline function length(v: Float3): Float return v.length();
overload extern inline function length(v: Float2): Float return v.length();
overload extern inline function length(v: Float): Float return Math.abs(v);

overload extern inline function distance(v: Float4, b: Float4): Float return v.distance(b);
overload extern inline function distance(v: Float3, b: Float3): Float return v.distance(b);
overload extern inline function distance(v: Float2, b: Float2): Float return v.distance(b);
overload extern inline function distance(v: Float, b: Float): Float return Math.abs(v - b);

overload extern inline function dot(v: Float4, b: Float4): Float return v.dot(b);
overload extern inline function dot(v: Float3, b: Float3): Float return v.dot(b);
overload extern inline function dot(v: Float2, b: Float2): Float return v.dot(b);
overload extern inline function dot(v: Float, b: Float): Float return (v * b);

overload extern inline function normalize(v: Float4): Float4 return v.normalized();
overload extern inline function normalize(v: Float3): Float3 return v.normalized();
overload extern inline function normalize(v: Float2): Float2 return v.normalized();
overload extern inline function normalize(v: Float) return v <= 0.0 ? 0.0 : 1.0;

overload extern inline function faceforward(v: Float4, I: Float4, Nref: Float4): Float4 return v.faceforward(I, Nref);
overload extern inline function faceforward(v: Float3, I: Float3, Nref: Float3): Float3 return v.faceforward(I, Nref);
overload extern inline function faceforward(v: Float2, I: Float2, Nref: Float2): Float2 return v.faceforward(I, Nref);
overload extern inline function faceforward(v: Float, I: Float, Nref: Float): Float return (I * Nref < 0 ? v : -v);

overload extern inline function reflect(I: Float4, N: Float4): Float4 return I.reflect(N);
overload extern inline function reflect(I: Float3, N: Float3): Float3 return I.reflect(N);
overload extern inline function reflect(I: Float2, N: Float2): Float2 return I.reflect(N);
overload extern inline function reflect(I: Float, N: Float): Float return I - 2 * (N * I) * N;

overload extern inline function refract(I: Float4, N: Float4, eta: Float): Float4 return I.refract(N, eta);
overload extern inline function refract(I: Float3, N: Float3, eta: Float): Float3 return I.refract(N, eta);
overload extern inline function refract(I: Float2, N: Float2, eta: Float): Float2 return I.refract(N, eta);
overload extern inline function refract(I: Float, N: Float, eta: Float): Float {
	var nDotI = I * N;
	var k = 1.0 - eta * eta * (1.0 - nDotI * nDotI);
	return if (k < 0.0) {
		0.0;
	} else {
		eta * I - (eta * nDotI + Math.sqrt(k)) * N;
	}
}

overload extern inline function matrixCompMult(m: Float4x4, n: Float4x4): Float4x4 return m.matrixCompMult(n);
overload extern inline function matrixCompMult(m: Float3x3, n: Float3x3): Float3x3 return m.matrixCompMult(n);
overload extern inline function matrixCompMult(m: Float2x2, n: Float2x2): Float2x2 return m.matrixCompMult(n);

// extended methods beyond GLSL ES 100
overload extern inline function transpose(m: Float4x4): Float4x4 return m.transpose();
overload extern inline function transpose(m: Float3x3): Float3x3 return m.transpose();
overload extern inline function transpose(m: Float2x2): Float2x2 return m.transpose();

overload extern inline function determinant(m: Float4x4): Float return m.determinant();
overload extern inline function determinant(m: Float3x3): Float return m.determinant();
overload extern inline function determinant(m: Float2x2): Float return m.determinant();

overload extern inline function inverse(m: Float4x4): Float4x4 return m.inverse();
overload extern inline function inverse(m: Float3x3): Float3x3 return m.inverse();
overload extern inline function inverse(m: Float2x2): Float2x2 return m.inverse();

overload extern inline function adjoint(m: Float4x4): Float4x4 return m.adjoint();
overload extern inline function adjoint(m: Float3x3): Float3x3 return m.adjoint();
overload extern inline function adjoint(m: Float2x2): Float2x2 return m.adjoint();

// special-case functions

overload extern inline function cross(a: Float3, b: Float3): Float3 {
	return a.cross(b);
}
// # Vector Initializers

overload extern inline function float2(m: Float4x4): Float2 return new Float2(m[0][0], m[0][1]);
overload extern inline function float2(m: Float3x3): Float2 return new Float2(m[0][0], m[0][1]);
overload extern inline function float2(m: Float2x2): Float2 return new Float2(m[0][0], m[0][1]);
overload extern inline function float2(xyzw: Float4): Float2 return new Float2(xyzw.x, xyzw.y);
overload extern inline function float2(xyz: Float3): Float2 return new Float2(xyz.x, xyz.y);
overload extern inline function float2(xy: Float2): Float2 return new Float2(xy.x, xy.y);
overload extern inline function float2(x: Float): Float2 return new Float2(x, x);
overload extern inline function float2(x: Float, y: Float): Float2 return new Float2(x, y);

overload extern inline function float3(m: Float4x4): Float3 return new Float3(m[0][0], m[0][1], m[0][2]);
overload extern inline function float3(m: Float3x3): Float3 return new Float3(m[0][0], m[0][1], m[0][2]);
overload extern inline function float3(m: Float2x2): Float3 return new Float3(m[0][0], m[0][1], m[1][0]);
overload extern inline function float3(xyzw: Float4): Float3 return new Float3(xyzw.x, xyzw.y, xyzw.z);
overload extern inline function float3(xyz: Float3): Float3 return new Float3(xyz.x, xyz.y, xyz.z);
overload extern inline function float3(x: Float, yz: Float2): Float3 return new Float3(x, yz.x, yz.y);
overload extern inline function float3(xy: Float2, z: Float): Float3 return new Float3(xy.x, xy.y, z);
overload extern inline function float3(x: Float): Float3 return new Float3(x, x, x);
overload extern inline function float3(x: Float, y: Float, z: Float): Float3 return new Float3(x, y, z);

overload extern inline function float4(m: Float4x4): Float4 return new Float4(m[0][0], m[0][1], m[0][2], m[0][3]);
overload extern inline function float4(m: Float3x3): Float4 return new Float4(m[0][0], m[0][1], m[0][2], m[1][0]);
overload extern inline function float4(m: Float2x2): Float4 return new Float4(m[0][0], m[0][1], m[1][0], m[1][1]);
overload extern inline function float4(xyzw: Float4): Float4 return new Float4(xyzw.x, xyzw.y, xyzw.z, xyzw.w);
overload extern inline function float4(x: Float, yzw: Float3): Float4 return new Float4(x, yzw.x, yzw.y, yzw.z);
overload extern inline function float4(xyz: Float3, w: Float): Float4 return new Float4(xyz.x, xyz.y, xyz.z, w);
overload extern inline function float4(xy: Float2, zw: Float2): Float4 return new Float4(xy.x, xy.y, zw.x, zw.y);
overload extern inline function float4(x: Float, y: Float, zw: Float2): Float4 return new Float4(x, y, zw.x, zw.y);
overload extern inline function float4(x: Float, yz: Float2, w: Float): Float4 return new Float4(x, yz.x, yz.y, w);
overload extern inline function float4(xy: Float2, z: Float, w: Float): Float4 return new Float4(xy.x, xy.y, z, w);
overload extern inline function float4(x: Float): Float4 return new Float4(x, x, x, x);
overload extern inline function float4(x: Float, y: Float, z: Float, w: Float): Float4 return new Float4(x, y, z, w);

overload extern inline function float2x2(m: Float4x4): Float2x2 return new Float2x2(m[0][0], m[0][1], m[1][0], m[1][1]);
overload extern inline function float2x2(m: Float3x3): Float2x2 return new Float2x2(m[0][0], m[0][1], m[1][0], m[1][1]);
overload extern inline function float2x2(m: Float2x2): Float2x2 return m.clone();
overload extern inline function float2x2(v: Float4): Float2x2 return new Float2x2(v.x, v.y, v.z, v.w);
overload extern inline function float2x2(column0: Float2, column1: Float2): Float2x2 return new Float2x2(column0.x, column0.y, column1.x, column1.y);
overload extern inline function float2x2(scale: Float): Float2x2 return new Float2x2(scale, 0.0, 0.0, scale);
overload extern inline function float2x2(a00: Float, a01: Float, a10: Float, a11: Float): Float2x2 return new Float2x2(a00, a01, a10, a11);

overload extern inline function float3x3(m: Float4x4): Float3x3 return new Float3x3(
	m[0][0], m[0][1], m[0][2],
	m[1][0], m[1][1], m[1][2],
	m[2][0], m[2][1], m[2][2]
);
overload extern inline function float3x3(m: Float3x3): Float3x3 return m.clone();
overload extern inline function float3x3(m: Float2x2): Float3x3 return new Float3x3(
	m[0][0], m[0][1], 0.0,
	m[1][0], m[1][1], 0.0,
	0.0, 0.0, 1.0
);
overload extern inline function float3x3(column0: Float3, column1: Float3, column2: Float3): Float3x3 return new Float3x3(
	column0.x, column0.y, column0.z,
	column1.x, column1.y, column1.z,
	column2.x, column2.y, column2.z
);
overload extern inline function float3x3(scale: Float): Float3x3 return new Float3x3(
	scale, 0.0, 0.0,
	0.0, scale, 0.0,
	0.0, 0.0, scale
);
overload extern inline function float3x3(
	a00: Float, a01: Float, a02: Float,
	a10: Float, a11: Float, a12: Float,
	a20: Float, a21: Float, a22: Float
): Float3x3 return new Float3x3(
	a00, a01, a02,
	a10, a11, a12,
	a20, a21, a22
);

overload extern inline function float4x4(m: Float4x4): Float4x4 return m.clone();
overload extern inline function float4x4(m: Float3x3): Float4x4 return new Float4x4(
	m[0][0], m[0][1], m[0][2], 0.0,
	m[1][0], m[1][1], m[1][2], 0.0,
	m[2][0], m[2][1], m[2][2], 0.0,
	0.0, 0.0, 0.0, 1.0
);
overload extern inline function float4x4(m: Float2x2): Float4x4 return new Float4x4(
	m[0][0], m[0][1], 0.0, 0.0,
	m[1][0], m[1][1], 0.0, 0.0,
	0.0, 0.0, 1.0, 0.0,
	0.0, 0.0, 0.0, 1.0
);
overload extern inline function float4x4(column0: Float4, column1: Float4, column2: Float4, column3: Float4): Float4x4 return new Float4x4(
	column0.x, column0.y, column0.z, column0.w,
	column1.x, column1.y, column1.z, column1.w,
	column2.x, column2.y, column2.z, column2.w,
	column3.x, column3.y, column3.z, column3.w
);
overload extern inline function float4x4(scale: Float): Float4x4 return new Float4x4(
	scale, 0.0, 0.0, 0.0,
	0.0, scale, 0.0, 0.0,
	0.0, 0.0, scale, 0.0,
	0.0, 0.0, 0.0, scale
);
overload extern inline function float4x4(
	a00: Float, a01: Float, a02: Float, a03: Float,
	a10: Float, a11: Float, a12: Float, a13: Float,
	a20: Float, a21: Float, a22: Float, a23: Float,
	a30: Float, a31: Float, a32: Float, a33: Float
): Float4x4 return new Float4x4(
	a00, a01, a02, a03,
	a10, a11, a12, a13,
	a20, a21, a22, a23,
	a30, a31, a32, a33
);

// internal methods
private inline function log2f(v: Float) {
	var l2 = Math.log(v) * 1.4426950408889634;

	// we must handle powers of 2 exactly to avoid unexpected behavior Floating point values, e.g. log2(8) ~ 2.9999... which may later be used in floor()
	var isPot = if (v % 1 == 0) {
		// is integer
		var i = Std.int(v);
		(i & (i - 1)) == 0; // is power of 2
	} else false;

	return isPot ? Math.round(l2) : l2;
}
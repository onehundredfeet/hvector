package hvector;

#if (vector_math_f32 && (cpp || hl || cs || java))
// override Float (usually f64) type with f32
// @:eager private typedef Float = Single;
#end
#if macro
import hvector.macro.SwizzleF;
#end

@:nullSafety
abstract Float3(Float3Data) to Float3Data from Float3Data {
	public inline function new(x:Float, y:Float, z:Float) {
		this = new Float3Data(x, y, z);
	}

	#if !macro
	public static inline function up():Float3
		return new Float3(0.0, 0.0, 1.0);

	public static inline function down():Float3
		return new Float3(0.0, 0.0, -1.0);

	public static inline function left():Float3
		return new Float3(-1.0, 0.0, 0.0);

	public static inline function right():Float3
		return new Float3(1.0, 0.0, 0.0);

	public static inline function one():Float3
		return new Float3(1.0, 1.0, 1.);

	public static inline function zero():Float3
		return new Float3(0.0, 0.0, 0.);

	public static inline function fromArray(a:Array<Float>, x = 0, y = 1, z = 2):Float3
		return new Float3(a[x], a[y], a[z]);

	public static inline function positiveInfinity():Float3
		return new Float3(Math.POSITIVE_INFINITY, Math.POSITIVE_INFINITY, Math.POSITIVE_INFINITY);

	public var x(get, set):Float;

	inline function get_x()
		return this.x;

	inline function set_x(v:Float)
		return this.x = v;

	public var y(get, set):Float;

	inline function get_y()
		return this.y;

	inline function set_y(v:Float)
		return this.y = v;

	public var z(get, set):Float;

	inline function get_z()
		return this.z;

	inline function set_z(v:Float)
		return this.z = v;

	public inline function copyFrom(v:Float3) {
		x = v.x;
		y = v.y;
		z = v.z;
		return this;
	}

	public inline function clone() {
		return new Float3(x, y, z);
	}

	// special case for Float3
	public inline function cross(b:Float3)
		return new Float3(y * b.z - z * b.y, z * b.x - x * b.z, x * b.y - y * b.x);

	// Trigonometric
	public inline function radians():Float3 {
		return (this : Float3) * Constants.PI / 180;
	}

	public inline function degrees():Float3 {
		return (this : Float3) * 180 / Constants.PI;
	}

	public inline function sin():Float3 {
		return new Float3(Math.sin(x), Math.sin(y), Math.sin(z));
	}

	public inline function cos():Float3 {
		return new Float3(Math.cos(x), Math.cos(y), Math.cos(z));
	}

	public inline function tan():Float3 {
		return new Float3(Math.tan(x), Math.tan(y), Math.tan(z));
	}

	public inline function asin():Float3 {
		return new Float3(Math.asin(x), Math.asin(y), Math.asin(z));
	}

	public inline function acos():Float3 {
		return new Float3(Math.acos(x), Math.acos(y), Math.acos(z));
	}

	public inline function atan():Float3 {
		return new Float3(Math.atan(x), Math.atan(y), Math.atan(z));
	}

	public inline function atan2(b:Float3):Float3 {
		return new Float3(Math.atan2(x, b.x), Math.atan2(y, b.y), Math.atan2(z, b.z));
	}

	// Exponential
	public inline function pow(e:Float3):Float3 {
		return new Float3(Math.pow(x, e.x), Math.pow(y, e.y), Math.pow(z, e.z));
	}

	public inline function exp():Float3 {
		return new Float3(Math.exp(x), Math.exp(y), Math.exp(z));
	}

	public inline function log():Float3 {
		return new Float3(Math.log(x), Math.log(y), Math.log(z));
	}

	public inline function exp2():Float3 {
		return new Float3(Math.pow(2, x), Math.pow(2, y), Math.pow(2, z));
	}

	public inline function log2():Float3 @:privateAccess {
		return new Float3(ShaderMath.log2f(x), ShaderMath.log2f(y), ShaderMath.log2f(z));
	}

	public inline function sqrt():Float3 {
		return new Float3(Math.sqrt(x), Math.sqrt(y), Math.sqrt(z));
	}

	public inline function inverseSqrt():Float3 {
		return 1.0 / sqrt();
	}

	// Common
	public inline function abs():Float3 {
		return new Float3(Math.abs(x), Math.abs(y), Math.abs(z));
	}

	public inline function sign():Float3 {
		return new Float3(x > 0.?1.:(x < 0.? -1.:0.), y > 0.?1.:(y < 0.? -1.:0.), z > 0.?1.:(z < 0.? -1.:0.));
	}

	public inline function floor():Float3 {
		return new Float3(Math.floor(x), Math.floor(y), Math.floor(z));
	}

	public inline function ceil():Float3 {
		return new Float3(Math.ceil(x), Math.ceil(y), Math.ceil(z));
	}

	public inline function fract():Float3 {
		return (this : Float3) - floor();
	}

	public extern overload inline function mod(d:Float3):Float3 {
		return (this : Float3) - d * ((this : Float3) / d).floor();
	}

	public extern overload inline function mod(d:Float):Float3 {
		return (this : Float3) - d * ((this : Float3) / d).floor();
	}

	public extern overload inline function min(b:Float3):Float3 {
		return new Float3(b.x < x ? b.x : x, b.y < y ? b.y : y, b.z < z ? b.z : z);
	}

	public extern overload inline function min(b:Float):Float3 {
		return new Float3(b < x ? b : x, b < y ? b : y, b < z ? b : z);
	}

	public extern overload inline function max(b:Float3):Float3 {
		return new Float3(x < b.x ? b.x : x, y < b.y ? b.y : y, z < b.z ? b.z : z);
	}

	public extern overload inline function max(b:Float):Float3 {
		return new Float3(x < b ? b : x, y < b ? b : y, z < b ? b : z);
	}

	public extern overload inline function clamp(minLimit:Float3, maxLimit:Float3) {
		return max(minLimit).min(maxLimit);
	}

	public extern overload inline function clamp(minLimit:Float, maxLimit:Float) {
		return max(minLimit).min(maxLimit);
	}

	public extern overload inline function mix(b:Float3, t:Float3):Float3 {
		return (this : Float3) * (1.0 - t) + b * t;
	}

	public extern overload inline function mix(b:Float3, t:Float):Float3 {
		return (this : Float3) * (1.0 - t) + b * t;
	}

	public extern overload inline function step(edge:Float3):Float3 {
		return new Float3(x < edge.x ? 0.0 : 1.0, y < edge.y ? 0.0 : 1.0, z < edge.z ? 0.0 : 1.0);
	}

	public extern overload inline function step(edge:Float):Float3 {
		return new Float3(x < edge ? 0.0 : 1.0, y < edge ? 0.0 : 1.0, z < edge ? 0.0 : 1.0);
	}

	public extern overload inline function smoothstep(edge0:Float3, edge1:Float3):Float3 {
		var t = (((this : Float3) - edge0) / (edge1 - edge0)).clamp(0, 1);
		return t * t * (3.0 - 2.0 * t);
	}

	public extern overload inline function smoothstep(edge0:Float, edge1:Float):Float3 {
		var t = (((this : Float3) - edge0) / (edge1 - edge0)).clamp(0, 1);
		return t * t * (3.0 - 2.0 * t);
	}

	// Geometric
	public inline function length():Float {
		return Math.sqrt(x * x + y * y + z * z);
	}

	public inline function distance(b:Float3):Float {
		return (b - this).length();
	}

	public inline function dot(b:Float3):Float {
		return x * b.x + y * b.y + z * b.z;
	}

	public inline function normalized():Float3 {
		var v:Float3 = this;
		var lenSq = v.dot(this);
		var denominator = lenSq == 0.0 ? 1.0 : Math.sqrt(lenSq); // for 0 length, return zero vector rather than infinity
		return v / denominator;
	}

	public inline function faceforward(I:Float3, Nref:Float3):Float3 {
		return new Float3(x, y, z) * (Nref.dot(I) < 0 ? 1 : -1);
	}

	public inline function reflect(N:Float3):Float3 {
		var I = (this : Float3);
		return I - 2 * N.dot(I) * N;
	}

	public inline function refract(N:Float3, eta:Float):Float3 {
		var I = (this : Float3);
		var nDotI = N.dot(I);
		var k = 1.0 - eta * eta * (1.0 - nDotI * nDotI);
		return (eta * I - (eta * nDotI + Math.sqrt(k)) * N) * (k < 0.0 ? 0.0 : 1.0); // if k < 0, result should be 0 vector
	}

	public inline function nearZero():Bool {
		return Math.abs(x) < Constants.EPSILON && Math.abs(y) < Constants.EPSILON && Math.abs(z) < Constants.EPSILON;
	}

	public inline function assign(x:Float, y:Float, z:Float):Float3 {
		this.x = x;
		this.y = y;
		this.z = z;
		return this;
	}

	public inline function assign3(v:Float3):Float3 {
		this.x = v.x;
		this.y = v.y;
		this.z = v.z;
		return this;
	}

	public inline function toString() {
		return 'Float3(${x}, ${y}, ${z})';
	}

	@:op([])
	inline function arrayRead(i:Int)
		return switch i {
			case 0: x;
			case 1: y;
			case 2: z;
			default: null;
		}

	@:op([])
	inline function arrayWrite(i:Int, v:Float)
		return switch i {
			case 0: x = v;
			case 1: y = v;
			case 2: z = v;
			default: null;
		}

	@:op(-a)
	static inline function neg(a:Float3)
		return new Float3(-a.x, -a.y, -a.z);

	@:op(++a)
	static inline function prefixIncrement(a:Float3) {
		++a.x;
		++a.y;
		++a.z;
		return a.clone();
	}

	@:op(--a)
	static inline function prefixDecrement(a:Float3) {
		--a.x;
		--a.y;
		--a.z;
		return a.clone();
	}

	@:op(a++)
	static inline function postfixIncrement(a:Float3) {
		var ret = a.clone();
		++a.x;
		++a.y;
		++a.z;
		return ret;
	}

	@:op(a--)
	static inline function postfixDecrement(a:Float3) {
		var ret = a.clone();
		--a.x;
		--a.y;
		--a.z;
		return ret;
	}

	// assignment overload should come before other binary ops to ensure they have priority

	@:op(a *= b)
	static inline function mulEq(a:Float3, b:Float3):Float3
		return a.copyFrom(a * b);

	@:op(a *= b)
	static inline function mulEqMat(a:Float3, b:Float3x3):Float3
		return a.copyFrom(a * b);

	@:op(a *= b)
	static inline function mulEqScalar(a:Float3, f:Float):Float3
		return a.copyFrom(a * f);

	@:op(a /= b)
	static inline function divEq(a:Float3, b:Float3):Float3
		return a.copyFrom(a / b);

	@:op(a /= b)
	static inline function divEqScalar(a:Float3, f:Float):Float3
		return a.copyFrom(a / f);

	@:op(a += b)
	static inline function addEq(a:Float3, b:Float3):Float3
		return a.copyFrom(a + b);

	@:op(a += b)
	static inline function addEqScalar(a:Float3, f:Float):Float3
		return a.copyFrom(a + f);

	@:op(a -= b)
	static inline function subEq(a:Float3, b:Float3):Float3
		return a.copyFrom(a - b);

	@:op(a -= b)
	static inline function subEqScalar(a:Float3, f:Float):Float3
		return a.copyFrom(a - f);

	@:op(a * b)
	static inline function mul(a:Float3, b:Float3):Float3
		return new Float3(a.x * b.x, a.y * b.y, a.z * b.z);

	@:op(a * b) @:commutative
	static inline function mulScalar(a:Float3, b:Float):Float3
		return new Float3(a.x * b, a.y * b, a.z * b);

	@:op(a / b)
	static inline function div(a:Float3, b:Float3):Float3
		return new Float3(a.x / b.x, a.y / b.y, a.z / b.z);

	@:op(a / b)
	static inline function divScalar(a:Float3, b:Float):Float3
		return new Float3(a.x / b, a.y / b, a.z / b);

	@:op(a / b)
	static inline function divScalarInv(a:Float, b:Float3):Float3
		return new Float3(a / b.x, a / b.y, a / b.z);

	@:op(a + b)
	static inline function add(a:Float3, b:Float3):Float3
		return new Float3(a.x + b.x, a.y + b.y, a.z + b.z);

	@:op(a + b) @:commutative
	static inline function addScalar(a:Float3, b:Float):Float3
		return new Float3(a.x + b, a.y + b, a.z + b);

	@:op(a - b)
	static inline function sub(a:Float3, b:Float3):Float3
		return new Float3(a.x - b.x, a.y - b.y, a.z - b.z);

	@:op(a - b)
	static inline function subScalar(a:Float3, b:Float):Float3
		return new Float3(a.x - b, a.y - b, a.z - b);

	@:op(b - a)
	static inline function subScalarInv(a:Float, b:Float3):Float3
		return new Float3(a - b.x, a - b.y, a - b.z);

	@:op(a == b)
	static inline function equal(a:Float3, b:Float3):Bool
		return a.x == b.x && a.y == b.y && a.z == b.z;

	@:op(a != b)
	static inline function notEqual(a:Float3, b:Float3):Bool
		return !equal(a, b);

	public inline function toArray():Array<Float> {
		return [x, y, z];
	}

	public inline function toFloat3Array():Float3A {
		return [x, y, z];
	}
	#end // !macro

	// macros
	@:op(a.b) macro function swizzleRead(self, name:String) {
		return SwizzleF.swizzleReadExprF(self, name);
	}

	@:op(a.b) macro function swizzleWrite(self, name:String, value) {
		return SwizzleF.swizzleWriteExprF(self, name, value);
	}

	@:overload(function<T>(arrayLike:T, index:Int):T {})
	public macro function copyIntoArray(self:haxe.macro.Expr.ExprOf<Float3>, array:haxe.macro.Expr.ExprOf<ArrayAccess<Float>>,
			index:haxe.macro.Expr.ExprOf<Int>) {
		return macro {
			var self = $self;
			var array = $array;
			var i:Int = $index;
			array[0 + i] = self.x;
			array[1 + i] = self.y;
			array[2 + i] = self.z;
			array;
		}
	}
}

@:noCompletion
@:struct
class Float3Data {
	public var x:Float;
	public var y:Float;
	public var z:Float;

	public inline function new(x:Float, y:Float, z:Float) {
		// the + 0.0 helps the optimizer realize it can collapse const float operations
		this.x = x + 0.0;
		this.y = y + 0.0;
		this.z = z + 0.0;
	}

	public function toString():String {
		return 'Float3Data(' + x + ', ' + y + ', ' + z + ')';
	}
}

@:forward
abstract Float3A(Array<Float>) from Array<Float> {
	@:arrayAccess public inline function get(index:Int) {
		return this[index];
	}

	@:arrayAccess public inline function set(index:Int, value:Float) {
		this[index] = value;
		return value;
	}

	public var x(get, set):Float;

	inline function get_x()
		return this[0];

	inline function set_x(v:Float)
		return this[0] = v;

	public var y(get, set):Float;

	inline function get_y()
		return this[1];

	inline function set_y(v:Float)
		return this[1] = v;

	public var z(get, set):Float;

	inline function get_z()
		return this[2];

	inline function set_z(v:Float)
		return this[2] = v;

	#if !macro
	@:op(a - b)
	static inline function subAA(a:Float3A, b:Float3A):Float3
		return new Float3(a.x - b.x, a.y - b.y, a.z - b.z);

	@:op(a - b)
	static inline function subA3(a:Float3A, b:Float3):Float3
		return new Float3(a.x - b.x, a.y - b.y, a.z - b.z);

	@:op(a - b)
	static inline function sub3A(a:Float3, b:Float3A):Float3
		return new Float3(a.x - b.x, a.y - b.y, a.z - b.z);
	#end
}

#if hl
abstract NativeArrayFloat3(hl.NativeArray<Float>) to hl.NativeArray<Float> from hl.NativeArray<Float> {
	@:arrayAccess
	public inline function get(idx:Int) {
		return new Float3(this[idx * 3 + 0], this[idx * 3 + 0], this[idx * 3 + 0]);
	}
}
#end

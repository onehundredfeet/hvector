package hvector;

import hvector.Float4;

/*
The MIT License (MIT)

Copyright (C) 2021 Ryan Cleven
Copyright (C) 2014-2020 Tommy Brosman

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

/**
 * Quaternion for rotation in 3D.
 */
@:forward(w, x, y, z)
abstract Quaternion(Float4Data) from Float4Data to Float4Data
{
    #if !macro
    // The number of elements in this structure
    public static inline var elementCount:Int = 4;
    
    // Zero quaternion (q + 0 = 0, q * 0 = 0)
    public static var zero(get, never):Quaternion;
    
    // One/identity quaternion (q * 1 = q)
    public static var identity(get, never):Quaternion;
    
    // Gets the corresponding rotation matrix
    public var matrix(get, never):Float3x3;
    
    // Magnitude
    public var length(get, never):Float;
    
    // Quaternion dotted with itself
    public var lengthSq(get, never):Float;
    
    // The normalized quaternion
    public var normal(get, never):Quaternion;
    
    /**
     * Constructor.
     * 
     * @param s     Scalar (real) part.
     * @param x     Vector (complex) part x component.
     * @param y     Vector (complex) part y component.
     * @param z     Vector (complex) part z component
     */
    public inline function new(s:Float, x:Float, y:Float, z:Float) 
    {
        this = new Float4Data(s, x, y, z);
    }
    
    /**
     * Construct a Quaternion from an array.
     * 
     * @param rawData   The input array.
     * @return          The constructed structure.
     */
    public static inline function fromArray(rawData:Array<Float>):Quaternion
    {
        if (rawData.length != Quaternion.elementCount)
        {
            throw "Invalid rawData.";
        }
        
        return new Quaternion(rawData[0], rawData[1], rawData[2], rawData[3]);
    }
    
    /**
     * Create a quaternion from an axis-angle pair.
     * 
     * @param angleRadians  The angle to rotate in Radians.
     * @param axis          The axis to rotate around.
     * @return              The quaternion.
     */
    public static inline function fromAxisAngle(angleRadians:Float, axis:Float3):Quaternion
    {
        var cosHalfAngle = Math.cos(angleRadians / 2.0);
        var sinHalfAngle = Math.sin(angleRadians / 2.0);
        
        return new Quaternion(
            cosHalfAngle,
            sinHalfAngle * axis.x,
            sinHalfAngle * axis.y,
            sinHalfAngle * axis.z);
    }
    
    /**
     * Multiply a (real) scalar with a quaternion.
     * 
     * @param a
     * @param s
     * @return      s * a
     */
    @:op(A * B)
    @:commutative
    public static inline function multiplyScalar(a:Quaternion, s:Float):Quaternion
    {
        return a.clone()
            .multiplyWithScalar(s);
    }
    
    /**
     * Multiply two quaternions.
     * 
     * @param a
     * @param b
     * @return      a * b
     */
    @:op(A * B)
    public static inline function multiply(a:Quaternion, b:Quaternion):Quaternion
    {
        return new Quaternion(
            a.w * b.w - a.x * b.x - a.y * b.y - a.z * b.z,
            a.w * b.x + b.w * a.x + a.y * b.z - a.z * b.y,
            a.w * b.y + b.w * a.y + a.z * b.x - a.x * b.z,
            a.w * b.z + b.w * a.z + a.x * b.y - a.y * b.x);
    }
    
    /**
     * Add two quaternions.
     * 
     * @param a
     * @param b
     * @return      a + b
     */
    @:op(A + B)
    public static inline function add(a:Quaternion, b:Quaternion):Quaternion
    {
        return a.clone().addWith(b);
    }
    
    /**
     * Subtract one quaternion from another.
     * 
     * @param a
     * @param b
     * @return      a - b
     */
    @:op(A - B)
    public static inline function subtract(a:Quaternion, b:Quaternion):Quaternion
    {
        return a.clone()
            .subtractWith(b);
    }

    /**
     * Create a complex conjugate copy of a quaternion (complex/vector portion is negated).
     * 
     * @param a
     * @return      a*
     */
    @:op(~A)
    public static inline function conjugate(a:Quaternion):Quaternion
    {
        return new Quaternion(a.w, -a.x, -a.y, -a.z);
    }
    
    /**
     * Create a negated copy of a quaternion.
     * 
     * @param a
     * @return      -a
     */
    @:op(-A)
    public static inline function negate(a:Quaternion):Quaternion
    {
        return new Quaternion(-a.w, -a.x, -a.y, -a.z);
    }
    
    /**
     * Test element-wise equality between two quaternions.
     * False if one of the inputs is null and the other is not.
     * 
     * @param a
     * @param b
     * @return     a_i == b_i
     */
    @:op(A == B)
    public static inline function equals(a:Quaternion, b:Quaternion):Bool
    {
        return (a == null && b == null) ||
            a != null &&
            b != null &&
            a.w == b.w &&
            a.x == b.x &&
            a.y == b.y &&
            a.z == b.z;
    }
    
    /**
     * Linear interpolation between two quaternions.
     * 
     * @param a     The value at t = 0
     * @param b     The value at t = 1
     * @param t     A number in the range [0, 1]
     * @return      The interpolated value
     */
    public static inline function lerp(a:Quaternion, b:Quaternion, t:Float):Quaternion
    {
        return (1.0 - t)*a + t*b;
    }
    
    public static inline function slerp(a:Quaternion, b:Quaternion, t:Float):Quaternion
    {
        var cosHalfTheta = Quaternion.dot(a, b);
        
        // If the two quaternions are nearly the same return the first one
        if (Math.abs(cosHalfTheta) >= 1.0)
        {
            return a;
        }
        
        var halfTheta = Math.acos(cosHalfTheta);
        var sinHalfTheta = Math.sqrt(1.0 - cosHalfTheta * cosHalfTheta);
        
        // Do not slerp if the result is ill-defined (a large angle near 180 Radians)
        if (Math.abs(sinHalfTheta) < 1e-3)
        {
            return Quaternion.lerp(a, b, t)
                .normalize();
        }
        
        var ta = Math.sin((1 - t) * halfTheta) / sinHalfTheta;
        var tb = Math.sin(t * halfTheta) / sinHalfTheta;
        
        var result:Quaternion = Quaternion.get_zero();
        
        result.x = a.x * ta + b.x * tb;
        result.y = a.y * ta + b.y * tb;
        result.z = a.z * ta + b.z * tb;
        result.w = a.w * ta + b.w * tb;
        
        return result;
    }
    
    /**
     * Dot product.
     * 
     * @param a
     * @return      sum_i (a_i * b_i)
     */
    public static inline function dot(a:Quaternion, b:Quaternion):Float
    {
        return a.w * b.w +
            a.x * b.x +
            a.y * b.y +
            a.z * b.z;
    }
    
    /**
     * Sets all the fields of this structure without allocation.
     * 
     * @param s
     * @param x
     * @param y
     * @param z
     * @return self
     */
    public inline function set(s:Float, x:Float, y:Float, z:Float):Quaternion
    {
        var self:Quaternion = this;
        
        self.w = s;
        self.x = x;
        self.y = y;
        self.z = z;
        
        return self;
    }
    
    /**
     * Create an inverted copy.
     * 
     * @return  The inverse.
     */
    public inline function invert():Quaternion
    {
        var self:Quaternion = this;
        
        return self.clone()
            .applyInvert();
    }
    
    /**
     * Multiply a quaternion with a scalar in place.
     * Note: *= operator on Haxe abstracts does not behave this way (a new object is returned).
     * 
     * @param a
     * @return      self_i *= s
     */
    public inline function multiplyWithScalar(s:Float):Quaternion
    {
        var self:Quaternion = this;
        
        self.w *= s;
        self.x *= s;
        self.y *= s;
        self.z *= s;
        
        return self;
    }
    
    /**
     * Add a quaternion in place.
     * Note: += operator on Haxe abstracts does not behave this way (a new object is returned).
     * 
     * @param a
     * @return      self_i += a_i
     */
    public inline function addWith(a:Quaternion):Quaternion
    {
        var self:Quaternion = this;
        
        self.w += a.w;
        self.x += a.x;
        self.y += a.y;
        self.z += a.z;
        
        return self;
    }
    
    /**
     * Subtract a quaternion in place.
     * Note: -= operator on Haxe abstracts does not behave this way (a new object is returned).
     * 
     * @param a
     * @return      self_i -= a_i
     */
    public inline function subtractWith(a:Quaternion):Quaternion
    {
        var self:Quaternion = this;
        
        self.w -= a.w;
        self.x -= a.x;
        self.y -= a.y;
        self.z -= a.z;
        
        return self;
    }
    
    /**
     * Copy the contents of this structure to another.
     * Faster than copyToShape for static platforms (C++, etc) but requires the target to have the exact same inner type.
     * 
     * @param target    The target structure.
     */
    public inline function copyTo(target:Quaternion):Void
    {
        var self:Quaternion = this;
        
        for (i in 0...Quaternion.elementCount)
        {
            target[i] = self[i];
        }
    }
    


    /**
     * Clone.
     * 
     * @return  The cloned object.
     */
    public inline function clone():Quaternion
    {
        var self:Quaternion = this;
        return new Quaternion(self.w, self.x, self.y, self.z);
    }
    
    /**
     * Get an element by position.
     * 
     * @param i         The element index.
     * @return          The element.
     */
    @:arrayAccess
    public inline function getArrayElement(i:Int):Float
    {
        var self:Quaternion = this;
        switch (i)
        {
            case 0:
                return self.w;
            case 1:
                return self.x;
            case 2:
                return self.y;
            case 3:
                return self.z;
            default:
                throw "Invalid element";
        }
    }
    
    /**
     * Set an element by position.
     * 
     * @param i         The element index.
     * @param value     The new value.
     * @return          The updated element.
     */
    @:arrayAccess
    public inline function setArrayElement(i:Int, value:Float):Float
    {
        var self:Quaternion = this;
        switch (i)
        {
            case 0:
                return self.w = value;
            case 1:
                return self.x = value;
            case 2:
                return self.y = value;
            case 3:
                return self.z = value;
            default:
                throw "Invalid element";
        }
    }
    
    /**
     * Apply a scalar function to each element.
     * 
     * @param func  The function to apply.
     * @return      The modified object.
     */
    public inline function applyScalarFunc(func:Float->Float):Quaternion
    {
        var self:Quaternion = this;
        
        for (i in 0...elementCount)
        {
            self[i] = func(self[i]);
        }
        
        return self;
    }

    /**
     * Get the log for the quaternion.
     * 
     * @return  log(q) == [0, theta/sin(theta) * v]
     */
    public inline function log():Quaternion
    {
        var self:Quaternion = this;
        var theta = Math.acos(self.w);
        var sinTheta = Math.sin(theta);
        
        // Avoid division by zero
        if (sinTheta > 0.0)
        {
            var k = theta / sinTheta;
            return new Quaternion(0.0, k * self.x, k * self.y, k * self.z);
        }
        else
        {
            return Quaternion.zero;
        }
    }
    
    /**
     * Get the exponential for the quaternion.
     * 
     * @return  exp(q) == [cos(theta), v * sin(theta)]
     */
    public inline function exp():Quaternion
    {
        var self:Quaternion = this;
        var theta = Math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z);
        var sinTheta = Math.sin(theta);
        var cosTheta = Math.cos(theta);

        // Avoid division by zero
        if(theta > 0.0)
        {
            return new Quaternion(cosTheta, sinTheta * self.x, sinTheta * self.y, sinTheta * self.z);
        }
        else
        {
            return new Quaternion(cosTheta, 0, 0, 0);
        }
    }
    
    /**
     * Rotate the given vector, assuming the current quaternion is normalized (if not, normalize first).
     * 
     * @param u     The vector to rotate.
     * @return      The rotated vector.
     */
    public inline function rotate(u:Float3):Float3
    {
        // Calculate qvq'
        var self:Quaternion = this;
        
        var a = 2.0 * (self.x * u.x + self.y * u.y + self.z * u.z);
        var b = self.w * self.w - self.x * self.x - self.y * self.y - self.z * self.z;
        var c = 2.0 * self.w;
        
        return new Float3(
            a * self.x + b * u.x + c * (self.y * u.z - self.z * u.y),
            a * self.y + b * u.y + c * (self.z * u.x - self.x * u.z),
            a * self.z + b * u.z + c * (self.x * u.y - self.y * u.x));
    }
    
    /**
     * Find the arccosine of the angle between two quaternions.
     * 
     * @param b     The other quaternion.
     * @return      The arccosine angle between this vector and the other in radians.
     */
    public inline function angleWith(b:Quaternion):Float
    {
        var self:Quaternion = this;
        return 2.0 * Math.acos(Quaternion.dot(self, b) / (self.length * b.length));
    }
    
    /**
     * Normalize the quaternion in-place.
     * 
     * @return  The modified object.
     */
    public inline function normalize():Quaternion
    {
        var self:Quaternion = this;
        var length = self.length;
        
        if (length > 0.0)
        {
            var k = 1.0 / length;
            self.multiplyWithScalar(k);
        }
        
        return self;
    }
    
    /**
     * Conjugate the quaternion in-place.
     * 
     * @return  The modified object.
     */
    public inline function applyConjugate():Quaternion
    {
        var self:Quaternion = this;
        
        self.x = -self.x;
        self.y = -self.y;
        self.z = -self.z;
        
        return self;
    }
    
    /**
     * Invert the quaternion in-place. Useful when the quaternion may have been denormalized.
     * 
     * @return  The modified object.
     */
    public inline function applyInvert():Quaternion
    {
        var self:Quaternion = this;
        
        return self.applyConjugate()
            .normalize();
    }
    
    private static inline function get_zero():Quaternion
    {
        return new Quaternion(0, 0, 0, 0);
    }
    
    private static inline function get_identity():Quaternion
    {
        return new Quaternion(1, 0, 0, 0);
    }
    
    private inline function get_length():Float
    {
        var self:Quaternion = this;
        return Math.sqrt(Quaternion.dot(self, self));
    }
    
    private inline function get_lengthSq():Float
    {
        var self:Quaternion = this;
        return Quaternion.dot(self, self);
    }
    
    private inline function get_matrix():Float3x3
    {
        var self:Quaternion = this;
      
        var s = self.w;
        var x = self.x;
        var y = self.y;
        var z = self.z;
        
        var m = new Float3x3(
            1 - 2 * (y * y + z * z), 2 * (x * y - s * z), 2 * (s * y + x * z),
            2 * (x * y + s * z), 1 - 2 * (x * x + z * z), 2 * (y * z - s * x),
            2 * (x * z - s * y), 2 * (y * z + s * x),  1 - 2 * (x * x + y * y));

        return m;
    }
    
    private inline function get_normal():Quaternion
    {
        var self:Quaternion = this;
        return (1.0 / self.length) * self;
    }
    #end
}
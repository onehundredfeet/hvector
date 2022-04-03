package hvector;

//
// Adapted from HIDE - https://github.com/HeapsIO/hide
//
class Curves {
	// Cubic Interpolation
	// p(t) = p0 * (1 - t)³ + p1 * t * 3 * (1 - t)² + p2 * t² * 3 * (1 - t) + p3 * t³
	// Only valid 0....1
	public inline static function evalCubicBezier3F( p0:Float3, p1:Float3, p2:Float3, p3:Float3, t:Float):Float3 {
		final one_minus_t = 1. - t;
		final one_minus_t2 = one_minus_t * one_minus_t;
		final t2 = t * t;

		return p0 * (one_minus_t2 * one_minus_t) + p1 * (t * 3 * one_minus_t2) + p2 * (t2 * 3 * one_minus_t) + p3 * (t2 * t);
	}

		// Quadratic Interpolation
	// p(t) = p0 * (1 - t)² + p1 * t * 2 * (1 - t) + p2 * t²
	public static inline function evalQuadraticBezier3F(p0:Float3, p1:Float3, p2:Float3, t:Float):Float3 {
		final one_minus_t = 1. - t;

		return p0 * (one_minus_t * one_minus_t) + p1 * (t * 2. * one_minus_t) + p2 * (t * t);
	}
}


/*

	// Linear Interpolation
	// p(t) = p0 + (p1 - p0) * t
	inline function getLinearBezierPoint(t:Float, p0:Float3, p1:Float3):Float3 {
		return p0 + (p1 - p0) * t;
	}

	// p'(t) = (p1 - p0)
	inline function getLinearBezierTangent(t:Float, p0:Float3, p1:Float3):Float3 {
		return (p1 - p0).normalized();
	}



	// p'(t) = 2 * (1 - t) * (p1 - p0) + 2 * t * (p2 - p1)
	inline function getQuadraticBezierTangent(t:Float, p0:Float3, p1:Float3, p2:Float3):Float3 {
		return p1.sub(p0).multiply(2 * (1 - t)).add(p2.sub(p1).multiply(2 * t)).normalized();
	}

	// Cubic Interpolation
	// p(t) = p0 * (1 - t)³ + p1 * t * 3 * (1 - t)² + p2 * t² * 3 * (1 - t) + p3 * t³
	inline function getCubicBezierPoint(t:Float, p0:Float3, p1:Float3, p2:Float3, p3:Float3):Float3 {
		return p0.multiply((1 - t) * (1 - t) * (1 - t))
			.add(p1.multiply(t * 3 * (1 - t) * (1 - t)))
			.add(p2.multiply(t * t * 3 * (1 - t)))
			.add(p3.multiply(t * t * t));
	}

	// p'(t) = 3 * (1 - t)² * (p1 - p0) + 6 * (1 - t) * t * (p2 - p1) + 3 * t² * (p3 - p2)
	inline function getCubicBezierTangent(t:Float, p0:Float3, p1:Float3, p2:Float3, p3:Float3):Float3 {
		return p1.sub(p0)
			.multiply(3 * (1 - t) * (1 - t))
			.add(p2.sub(p1).multiply(6 * (1 - t) * t))
			.add(p3.sub(p2).multiply(3 * t * t))
			.normalized();
	}

*/
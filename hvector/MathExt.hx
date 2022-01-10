package hvector;

#if (cpp || hl || cs || java)

overload extern inline function min(a:Single, b:Single):Single
	return (a < b) ? a : b;

overload extern inline function max(a:Single, b:Single):Single
	return (a > b) ? a : b;

// This seems odd, having to mark it as extern to avoid the overload check?
overload extern inline function repeat(t:Single, length:Single):Single {
	var x = t - Math.floor(t / length) * length;

	var zero : Single = 0.;

	return max(min(x, length), zero);
}

overload extern inline function clamp01(t:Single) {
	if (t < 0.0)
		return 0.0;
	if (t > 1.0)
		return 1.0;
	return t;
}

overload extern inline function sign(n:Single):Single
	return n >= 0.?1.: -1.;

overload extern inline function toInt(n:Single):Int
	return Std.int(n);


#end

overload extern inline function min(a:Float, b:Float):Float
	return (a < b) ? a : b;

overload extern inline function max(a:Float, b:Float):Float
	return (a > b) ? a : b;

overload extern inline function repeat(t:Float, length:Float):Float {
	var x = t - Math.floor(t / length) * length;

	return max(min(x, length), 0.0);
}

overload extern inline function clamp01(t:Float) {
	if (t < 0.0)
		return 0.0;
	if (t > 1.0)
		return 1.0;
	return t;
}

overload extern inline function clamp(t:Float, l:Float, u:Float):Float {
	if (t < l)
		return l;
	if (t > u)
		return u;
	return t;
}

overload extern inline function sign(n:Float):Float
	return n >= 0.?1.: -1.;

overload extern inline function toInt(n:Float):Int
	return Std.int(n);



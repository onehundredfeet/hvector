#if  (cpp || hl || cs || java)

overload extern inline function repeat( t : Single, length : Single) : Single {
    var x = t - Math.floor(t / length) * length;

    return Math.max(Math.min( x, length), 0.0);
}

overload extern inline function clamp01( t : Single ) {
    if (t < 0.0) return 0.0;
    if (t > 1.0) return 1.0;
    return t;
}

#end


overload extern inline function repeat( t : Float, length : Float) : Float{
    var x = t - Math.floor(t / length) * length;

    return Math.max(Math.min( x, length), 0.0);
}



overload extern inline function clamp01( t : Float ) {
    if (t < 0.0) return 0.0;
    if (t > 1.0) return 1.0;
    return t;
}

overload extern inline function clamp( t : Float, l : Float, u : Float ) : Float{
    if (t < l) return l;
    if (t >u) return u;
    return t;
}




package hvector;

#if js
typedef Single=Float;
#end

#if neko
typedef Single=Float;
#end

#if ucpp_runtime

//typedef Single=ucpp.num.Float32;
typedef Single=Float;
#end

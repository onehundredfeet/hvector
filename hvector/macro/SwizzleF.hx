package hvector.macro;

#if macro
import haxe.macro.Expr;
import haxe.macro.Context;
/**
	Macros required by VectorMath
	we use exceptions rather than Context.error for compile-time performance; it saves parsing and typing all the types included when using Context

	xyzw
	rgba
	stpq
**/
class SwizzleF {
public static function swizzleReadExprF(self: haxe.macro.Expr, name: String) {
	var f = fields(name, self.pos);
	var f0 = f[0];
	var f1 = f[1];
	var f2 = f[2];
	var f3 = f[3];
	return switch name.length {
		case 1:
			macro {
				var self = $self;
				self.$f0;
			}
		case 2:
			macro {
				var self = $self;
				new Float2(self.$f0, self.$f1);
			}
		case 3:
			macro {
				var self = $self;
				new Float3(self.$f0, self.$f1, self.$f2);
			}
		case 4:
			macro {
				var self = $self;
				new Float4(self.$f0, self.$f1, self.$f2, self.$f3);
			}
		default:
			throw 'Unsupported swizzle read ".$name"';
	}
}

public static function swizzleWriteExprF(self: haxe.macro.Expr, name: String, value) {
	var f = fields(name, self.pos);
	var f0 = f[0];
	var f1 = f[1];
	var f2 = f[2];
	var f3 = f[3];
	return switch name.length {
		case 1:
			macro {
				var self = $self;
				self.$f0 = $value;
			}
		case 2:
			if (f0 == f1) {
				throw 'Swizzle ".$name" disallowed because of duplicate field write';
			}
			

			macro {
				var self = $self;
				var value: Float2 = $value;
				self.$f0 = value.x;
				self.$f1 = value.y;
				value;
			}
		case 3:
			if (
				f0 == f1 || f0 == f2 ||
				f1 == f2
			) {
				throw 'Swizzle ".$name" disallowed because of duplicate field write';
			}
			macro {
				var self = $self;
				var value: Float3 = $value;
				self.$f0 = value.x;
				self.$f1 = value.y;
				self.$f2 = value.z;
				value;
			}
		case 4:
			if (
				f0 == f1 || f0 == f2 || f0 == f3 ||
				f1 == f2 || f1 == f3 || 
				f2 == f3
			) {
				throw 'Swizzle ".$name" disallowed because of duplicate field write';
			}
			macro {
				var self = $self;
				var value: Float4 = $value;
				self.$f0 = value.x;
				self.$f1 = value.y;
				self.$f2 = value.z;
				self.$f3 = value.w;
				value;
			}
		default:
			throw 'Unsupported swizzle write ".$name"';
	}
}

private static function fields(swizzle: String, pos:Position): Array<String> {
	var c0 = swizzle.charAt(0);
	return if (c0 >= 'w') { // xyzw
		[for (i in 0...swizzle.length) swizzle.charAt(i)];
	} else if (c0 == 'r' || c0 < 'p') { // rgba
		[for (i in 0...swizzle.length) {
			switch swizzle.charAt(i) {
				case 'r': 'x';
				case 'g': 'y';
				case 'b': 'z';
				case 'a': 'w';
				case c: Context.fatalError(  'Vector component "$c" not in set rgba|xyzw', pos);
			}
		}];
	} else { // stpq
		[for (i in 0...swizzle.length) {
			switch swizzle.charAt(i) {
				case 's': 'x';
				case 't': 'y';
				case 'p': 'z';
				case 'q': 'w';
				case c: throw 'Vector component "$c" not in set stpq';
			}
		}];
	}
}
}

#end
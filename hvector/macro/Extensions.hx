package hvector.macro;

// Tiny selection of tink_macro to avoid dependency
// https://github.com/haxetink/tink_macro
#if macro
import haxe.macro.Expr;
import haxe.macro.MacroStringTools;
import haxe.macro.Context;

class Extensions {
	static public inline function sanitize(pos:Position)
		return if (pos == null) Context.currentPos(); else pos;

	static public inline function at(e:ExprDef, ?pos:Position)
		return {
			expr: e,
			pos: sanitize(pos)
		};

	static public function asTypePath(s:String, ?params):TypePath {
		var parts = s.split('.');
		var name = parts.pop(), sub = null;
		if (parts.length > 0 && parts[parts.length - 1].charCodeAt(0) < 0x5B) {
			sub = name;
			name = parts.pop();
			if (sub == name)
				sub = null;
		}
		return {
			name: name,
			pack: parts,
			params: params == null ? [] : params,
			sub: sub
		};
	}

	static public inline function asComplexType(s:String, ?params)
		return TPath(asTypePath(s, params));

	static public inline function toMBlock(exprs:Array<Expr>, ?pos)
		return at(EBlock(exprs), pos);

	static public inline function toBlock(exprs:Iterable<Expr>, ?pos)
		return toMBlock(Lambda.array(exprs), pos);


	static public inline function binOp(e1:Expr, e2, op, ?pos)
		return at(EBinop(op, e1, e2), pos);

	static public inline function assign(target:Expr, value:Expr, ?op:Binop, ?pos:Position)
		return binOp(target, value, op == null ? OpAssign : OpAssignOp(op), pos);

	static public inline function field(x:Expr, member:String, ?pos):Expr {
		return at(EField(x, member), pos);
	}
}
#end

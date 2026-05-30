class dUtils.functions.Vector2D {
	var x:Number;
	var y:Number;
	function Vector2D(px:Number,py:Number){
		x = (px==undefined) ? 0 : px;
		y = (py==undefined) ? 0 : py;
	}
	static var ZERO:Vector2D = new Vector2D(0,0);
	static var ONE:Vector2D = new Vector2D(1,1);
	static var UP:Vector2D = new Vector2D(0,-1);
	static var DOWN:Vector2D = new Vector2D(0,1);
	static var LEFT:Vector2D = new Vector2D(-1,0);
	static var RIGHT:Vector2D = new Vector2D(1,0);

	function magnitude():Number{
		return Math.sqrt(x*x+y*y);
	}
	function magnitudeSq():Number{
		return x*x+y*y;
	}
	function normalize():Vector2D{
		var m:Number = magnitude();
		if(m==0) return new Vector2D(0,0);
		return new Vector2D(x/m,y/m);
	}
	function normalizeLocal():Void{
		var m:Number = magnitude();
		if(m==0){ x=0; y=0; return; }
		x/=m; y/=m;
	}
	function add(v:Vector2D):Vector2D{
		return new Vector2D(x+v.x,y+v.y);
	}
	function addLocal(v:Vector2D):Void{
		x+=v.x; y+=v.y;
	}
	function sub(v:Vector2D):Vector2D{
		return new Vector2D(x-v.x,y-v.y);
	}
	function subLocal(v:Vector2D):Void{
		x-=v.x; y-=v.y;
	}
	function scale(s:Number):Vector2D{
		return new Vector2D(x*s,y*s);
	}
	function scaleLocal(s:Number):Void{
		x*=s; y*=s;
	}
	function dot(v:Vector2D):Number{
		return x*v.x+y*v.y;
	}
	function cross(v:Vector2D):Number{
		return x*v.y-y*v.x;
	}
	function distanceTo(v:Vector2D):Number{
		var dx:Number = x-v.x;
		var dy:Number = y-v.y;
		return Math.sqrt(dx*dx+dy*dy);
	}
	function distanceSqTo(v:Vector2D):Number{
		var dx:Number = x-v.x;
		var dy:Number = y-v.y;
		return dx*dx+dy*dy;
	}
	function angle():Number{
		return Math.atan2(y,x);
	}
	function angleDeg():Number{
		return Math.atan2(y,x)*(180/Math.PI);
	}
	function angleTo(v:Vector2D):Number{
		return Math.atan2(v.y-y,v.x-x);
	}
	function angleBetween(v:Vector2D):Number{
		var m1:Number = magnitude();
		var m2:Number = v.magnitude();
		if(m1==0 || m2==0) return 0;
		var d:Number = dot(v)/(m1*m2);
		if(d>1) d=1;
		if(d<-1) d=-1;
		return Math.acos(d);
	}
	function rotate(rad:Number):Vector2D{
		var c:Number = Math.cos(rad);
		var s:Number = Math.sin(rad);
		return new Vector2D(x*c-y*s,x*s+y*c);
	}

	function rotateLocal(rad:Number):Void{
		var c:Number = Math.cos(rad);
		var s:Number = Math.sin(rad);
		var nx:Number = x*c-y*s;
		var ny:Number = x*s+y*c;
		x=nx; y=ny;
	}

	function rotateDeg(deg:Number):Vector2D{
		return rotate(deg*(Math.PI/180));
	}

	function perpendicular():Vector2D{
		return new Vector2D(-y,x);
	}

	function perpendicularCW():Vector2D{
		return new Vector2D(y,-x);
	}

	function reflect(normal:Vector2D):Vector2D{
		var n:Vector2D = normal.normalize();
		var d:Number = 2*dot(n);
		return new Vector2D(x-d*n.x,y-d*n.y);
	}
	function project(v:Vector2D):Vector2D{
		var m:Number = v.magnitudeSq();
		if(m==0) return new Vector2D(0,0);
		var s:Number = dot(v)/m;
		return new Vector2D(v.x*s,v.y*s);
	}
	function reject(v:Vector2D):Vector2D{
		return sub(project(v));
	}
	function lerp(v:Vector2D,t:Number):Vector2D{
		return new Vector2D(x+(v.x-x)*t,y+(v.y-y)*t);
	}
	function clampMagnitude(max:Number):Vector2D{
		if(magnitudeSq()>max*max) return normalize().scale(max);
		return clone();
	}
	function limit(max:Number):Void{
		if(magnitudeSq()>max*max){
			normalizeLocal();
			scaleLocal(max);
		}
	}

	function negate():Vector2D{
		return new Vector2D(-x,-y);
	}
	function negateLocal():Void{
		x=-x; y=-y;
	}
	function abs():Vector2D{
		return new Vector2D(Math.abs(x),Math.abs(y));
	}
	function setMagnitude(m:Number):Vector2D{
		return normalize().scale(m);
	}
	function isZero():Boolean{
		return x==0 && y==0;
	}
	function equals(v:Vector2D):Boolean{
		return x==v.x && y==v.y;
	}
	function equalsEpsilon(v:Vector2D,eps:Number):Boolean{
		var e:Number = (eps==undefined) ? 0.0001 : eps;
		return Math.abs(x-v.x)<=e && Math.abs(y-v.y)<=e;
	}
	function set(px:Number,py:Number):Void{
		x=px; y=py;
	}
	function copyFrom(v:Vector2D):Void{
		x=v.x; y=v.y;
	}
	function clone():Vector2D{
		return new Vector2D(x,y);
	}
	function toArray():Array{
		return [x,y];
	}
	function toString():String{
		return "Vector2D("+x+", "+y+")";
	}
	static function fromAngle(rad:Number,len:Number):Vector2D{
		var l:Number = (len==undefined) ? 1 : len;
		return new Vector2D(Math.cos(rad)*l,Math.sin(rad)*l);
	}
	static function fromAngleDeg(deg:Number,len:Number):Vector2D{
		return fromAngle(deg*(Math.PI/180),len);
	}
	static function fromArray(arr:Array):Vector2D{
		return new Vector2D(arr[0],arr[1]);
	}
	static function random(len:Number):Vector2D{
		var l:Number = (len==undefined) ? 1 : len;
		return fromAngle(Math.random()*Math.PI*2,l);
	}
	static function lerpStatic(a:Vector2D,b:Vector2D,t:Number):Vector2D{
		return a.lerp(b,t);
	}
	static function dotStatic(a:Vector2D,b:Vector2D):Number{
		return a.dot(b);
	}
	static function distance(a:Vector2D,b:Vector2D):Number{
		return a.distanceTo(b);
	}
	static function distanceSq(a:Vector2D,b:Vector2D):Number{
		return a.distanceSqTo(b);
	}
	static function angleBetweenStatic(a:Vector2D,b:Vector2D):Number{
		return a.angleBetween(b);
	}
}

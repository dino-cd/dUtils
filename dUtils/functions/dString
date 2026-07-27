class dUtils.functions.dString {
	static function trim(s:String):String {
		return ltrim(rtrim(s));
	}
  
	static function ltrim(s:String):String {
		var i:Number = 0;
		while (i < s.length && (s.charCodeAt(i) == 32 || s.charCodeAt(i) == 9 || s.charCodeAt(i) == 10 || s.charCodeAt(i) == 13)) {
			i++;
		}
		return s.substring(i);
	}

	static function rtrim(s:String):String {
		var i:Number = s.length - 1;
		while (i >= 0 && (s.charCodeAt(i) == 32 || s.charCodeAt(i) == 9 || s.charCodeAt(i) == 10 || s.charCodeAt(i) == 13)) {
			i--;
		}
		return s.substring(0, i + 1);
	}

	static function startsWith(s:String, prefix:String):Boolean {
		if (prefix.length > s.length) return false;
		return s.substring(0, prefix.length) == prefix;
	}

	static function endsWith(s:String, suffix:String):Boolean {
		if (suffix.length > s.length) return false;
		return s.substring(s.length - suffix.length) == suffix;
	}

	static function contains(s:String, sub:String):Boolean {
		return s.indexOf(sub) != -1;
	}

	static function repeat(s:String, n:Number):String {
		var out:String = "";
		for (var i=0;i<n;i++) {
			out += s;
		}
		return out;
	}

	static function padLeft(s:String, len:Number, ch:String):String {
		if (ch == undefined || ch == "") ch = " ";
		while (s.length < len) {
			s = ch + s;
		}
		return s;
	}

	static function padRight(s:String, len:Number, ch:String):String {
		if (ch == undefined || ch == "") ch = " ";
		while (s.length < len) {
			s = s + ch;
		}
		return s;
	}

	static function replaceAll(s:String, find:String, rep:String):String {
		var out:String = "";
		var flen:Number = find.length;
		var idx:Number = s.indexOf(find);
		while (idx != -1) {
			out += s.substring(0, idx) + rep;
			s = s.substring(idx + flen);
			idx = s.indexOf(find);
		}
		return out + s;
	}

	static function split(s:String, delim:String):Array {
		var arr:Array = [];
		var dlen:Number = delim.length;
		var idx:Number = s.indexOf(delim);
		while (idx != -1) {
			arr.push(s.substring(0, idx));
			s = s.substring(idx + dlen);
			idx = s.indexOf(delim);
		}
		arr.push(s);
		return arr;
	}

	static function countOccurrences(s:String, sub:String):Number {
		var n:Number = 0;
		var slen:Number = sub.length;
		var idx:Number = s.indexOf(sub);
		while (idx != -1) {
			n++;
			s = s.substring(idx + slen);
			idx = s.indexOf(sub);
		}
		return n;
	}

	static function reverse(s:String):String {
		var out:String = "";
		for (var i=s.length-1;i>=0;i--) {
			out += s.charAt(i);
		}
		return out;
	}

	static function capitalize(s:String):String {
		if (s.length == 0) return s;
		return s.charAt(0).toUpperCase() + s.substring(1).toLowerCase();
	}

	static function titleCase(s:String):String {
		var words:Array = s.split(" ");
		for (var i=0;i<words.length;i++) {
			words[i] = capitalize(words[i]);
		}
		return words.join(" ");
	}

	static function isNumeric(s:String):Boolean {
		if (s.length == 0) return false;
		for (var i=0;i<s.length;i++) {
			var code:Number = s.charCodeAt(i);
			if (i == 0 && (code == 43 || code == 45)) continue;
			if (code == 46) continue;
			if (code < 48 || code > 57) return false;
		}
		return true;
	}

	static function isAlpha(s:String):Boolean {
		if (s.length == 0) return false;
		for (var i=0;i<s.length;i++) {
			var code:Number = s.charCodeAt(i);
			if (!((code >= 65 && code <= 90) || (code >= 97 && code <= 122))) return false;
		}
		return true;
	}

	static function isAlphaNumeric(s:String):Boolean {
		if (s.length == 0) return false;
		for (var i=0;i<s.length;i++) {
			var code:Number = s.charCodeAt(i);
			if (!((code >= 65 && code <= 90) || (code >= 97 && code <= 122) || (code >= 48 && code <= 57))) return false;
		}
		return true;
	}

	static function truncate(s:String, maxLen:Number, tail:String):String {
		if (tail == undefined) tail = "...";
		if (s.length <= maxLen) return s;
		return s.substring(0, maxLen - tail.length) + tail;
	}

	static function stripTags(s:String):String {
		var out:String = "";
		var inside:Boolean = false;
		for (var i=0;i<s.length;i++) {
			var ch:String = s.charAt(i);
			if (ch == "<") {
				inside = true;
			} else if (ch == ">") {
				inside = false;
			} else if (!inside) {
				out += ch;
			}
		}
		return out;
	}

	static function toArray(s:String):Array {
		var arr:Array = [];
		for (var i=0;i<s.length;i++) {
			arr.push(s.charAt(i));
		}
		return arr;
	}

	static function fromCharCodes(arr:Array):String {
		var out:String = "";
		for (var i=0;i<arr.length;i++) {
			out += String.fromCharCode(arr[i]);
		}
		return out;
	}

	static function toCharCodes(s:String):Array {
		var arr:Array = [];
		for (var i=0;i<s.length;i++) {
			arr.push(s.charCodeAt(i));
		}
		return arr;
	}

	static function indexOfNth(s:String, sub:String, n:Number):Number {
		var idx:Number = -1;
		var found:Number = 0;
		var pos:Number = 0;
		while (true) {
			idx = s.indexOf(sub, pos);
			if (idx == -1) return -1;
			found++;
			if (found == n) return idx;
			pos = idx + sub.length;
		}
		return -1;
	}

	static function isEmpty(s:String):Boolean {
		return (s == undefined || s == null || s.length == 0);
	}

	static function isBlank(s:String):Boolean {
		return (s == undefined || s == null || trim(s).length == 0);
	}

	static function insert(s:String, pos:Number, ins:String):String {
		return s.substring(0, pos) + ins + s.substring(pos);
	}

	static function remove(s:String, pos:Number, len:Number):String {
		return s.substring(0, pos) + s.substring(pos + len);
	}

	static function compareIgnoreCase(a:String, b:String):Number {
		var la:String = a.toLowerCase();
		var lb:String = b.toLowerCase();
		if (la < lb) return -1;
		if (la > lb) return 1;
		return 0;
	}

	static function equalsIgnoreCase(a:String, b:String):Boolean {
		return a.toLowerCase() == b.toLowerCase();
	}

	static function wrap(s:String, lineLen:Number):String {
		var words:Array = s.split(" ");
		var out:String = "";
		var cur:String = "";
		for (var i=0;i<words.length;i++) {
			var w:String = words[i];
			if (cur.length == 0) {
				cur = w;
			} else if (cur.length + 1 + w.length <= lineLen) {
				cur += " " + w;
			} else {
				out += cur + "\n";
				cur = w;
			}
		}
		if (cur.length > 0) out += cur;
		return out;
	}

	static function format(template:String, args:Array):String {
		var out:String = template;
		for (var i=0;i<args.length;i++) {
			out = replaceAll(out, "{" + i + "}", String(args[i]));
		}
		return out;
	}

}

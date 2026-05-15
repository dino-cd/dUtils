class dUtils.Array.dArray {
    private var _data:Array;
    public function dArray() {
        if (arguments.length == 1 && (arguments[0] instanceof Array)) {
            _data = arguments[0].slice(); // cop
        } else {
            _data = [];
            for (var i:Number = 0; i < arguments.length; i++) {
                _data.push(arguments[i]);
            }
        }
    }
    public function get length():Number { return _data.length; }
    public function set length(n:Number):Void { _data.length = n; }
    public function getAt(i:Number) { return _data[i]; }
    public function setAt(i:Number, value):Void { _data[i] = value; }
    public function includes(searchElement, fromIndex:Number):Object {
        var start:Number = _resolveFromIndex(fromIndex);
        for (var i:Number = start; i < _data.length; i++) {
            if (_strictEqual(_data[i], searchElement)) {
                return { found: true, index: i };
            }
        }
        return { found: false, index: -1 };
    }
    public function indexOf(searchElement, fromIndex:Number):Number {
        var start:Number = _resolveFromIndex(fromIndex);
        for (var i:Number = start; i < _data.length; i++) {
            if (_strictEqual(_data[i], searchElement)) return i;
        }
        return -1;
    }
    public function lastIndexOf(searchElement, fromIndex:Number):Number {
        var start:Number;
        if (fromIndex == undefined || fromIndex == null) {
            start = _data.length - 1;
        } else {
            start = fromIndex < 0
                ? Math.max(0, _data.length + fromIndex)
                : Math.min(fromIndex, _data.length - 1);
        }
        for (var i:Number = start; i >= 0; i--) {
            if (_strictEqual(_data[i], searchElement)) return i;
        }
        return -1;
    }
    public function every(callbackFn:Function, thisObj:Object):Boolean {
        for (var i:Number = 0; i < _data.length; i++) {
            if (!callbackFn.call(thisObj, _data[i], i, _data)) return false;
        }
        return true;
    }
    public function some(callbackFn:Function, thisObj:Object):Boolean {
        for (var i:Number = 0; i < _data.length; i++) {
            if (callbackFn.call(thisObj, _data[i], i, _data)) return true;
        }
        return false;
    }
    public function filter(callbackFn:Function, thisObj:Object):dArray {
        var result:Array = [];
        for (var i:Number = 0; i < _data.length; i++) {
            if (callbackFn.call(thisObj, _data[i], i, _data)) {
                result.push(_data[i]);
            }
        }
        return new dArray(result);
    }
    public function map(callbackFn:Function, thisObj:Object):dArray {
        var result:Array = [];
        for (var i:Number = 0; i < _data.length; i++) {
            result.push(callbackFn.call(thisObj, _data[i], i, _data));
        }
        return new dArray(result);
    }
    public function forEach(callbackFn:Function, thisObj:Object):Void {
        for (var i:Number = 0; i < _data.length; i++) {
            callbackFn.call(thisObj, _data[i], i, _data);
        }
    }
    public function find(callbackFn:Function, thisObj:Object) {
        for (var i:Number = 0; i < _data.length; i++) {
            if (callbackFn.call(thisObj, _data[i], i, _data)) return _data[i];
        }
        return undefined;
    }
    public function findIndex(callbackFn:Function, thisObj:Object):Number {
        for (var i:Number = 0; i < _data.length; i++) {
            if (callbackFn.call(thisObj, _data[i], i, _data)) return i;
        }
        return -1;
    }
    public function flat(depth:Number):dArray {
        if (depth == undefined || depth == null) depth = 1;
        var result:Array = _flatNative(_data, depth);
        return new dArray(result);
    }
    public function fill(value, start:Number, end:Number):dArray {
        if (start == undefined || start == null) start = 0;
        if (end   == undefined || end   == null) end   = _data.length;
        if (start < 0) start = Math.max(0, _data.length + start);
        if (end   < 0) end   = Math.max(0, _data.length + end);
        for (var i:Number = start; i < end && i < _data.length; i++) {
            _data[i] = value;
        }
        return this;
    }
    public function copyWithin(target:Number, start:Number, end:Number):dArray {
        var len:Number = _data.length;
        if (start == undefined || start == null) start = 0;
        if (end   == undefined || end   == null) end   = len;
        // normalise negatives
        target = target < 0 ? Math.max(0, len + target) : Math.min(target, len);
        start  = start  < 0 ? Math.max(0, len + start)  : Math.min(start, len);
        end    = end    < 0 ? Math.max(0, len + end)     : Math.min(end, len);
        var copy:Array = _data.slice(start, end);
        for (var i:Number = 0; i < copy.length && (target + i) < len; i++) {
            _data[target + i] = copy[i];
        }
        return this;
    }
    public function at(index:Number) { //!!!!!!!!!!!!!!!!!!!!all
        if (index < 0) index = _data.length + index;
        return _data[index];
    }
    public function eitherHas(value):Boolean {
        for (var i:Number = 0; i < _data.length; i++) {
            if (_strictEqual(_data[i], value)) return true;
        }
        return false;
    }
    public function push():Number {
        for (var i:Number = 0; i < arguments.length; i++) {
            _data.push(arguments[i]);
        }
        return _data.length;
    }
    public function pop() { return _data.pop(); }
    public function shift() { return _data.shift(); }
    public function unshift():Number {
        var prepend:Array = [];
        for (var i:Number = 0; i < arguments.length; i++) prepend.push(arguments[i]);
        _data = prepend.concat(_data);
        return _data.length;
    }
    public function splice(start:Number, deleteCount:Number):dArray {
        var insertItems:Array = [];
        for (var i:Number = 2; i < arguments.length; i++) {
            insertItems.push(arguments[i]);
        }
        var removed:Array;
        if (insertItems.length > 0) {
            removed = _data.splice(start, deleteCount);
            for (var j:Number = insertItems.length - 1; j >= 0; j--) {
                _data.splice(start, 0, insertItems[j]);
            }
        } else {
            removed = _data.splice(start, deleteCount);
        }
        return new dArray(removed);
    }
    public function slice(start:Number, end:Number):dArray {
        var s:Array;
        if (end == undefined || end == null) {
            s = _data.slice(start);
        } else {
            s = _data.slice(start, end);
        }
        return new dArray(s);
    }
    public function concat():dArray {
        var merged:Array = _data.slice();
        for (var i:Number = 0; i < arguments.length; i++) {
            var arg = arguments[i];
            if (arg instanceof dArray) {
                merged = merged.concat(arg.toArray());
            } else if (arg instanceof Array) {
                merged = merged.concat(arg);
            } else {
                merged.push(arg);
            }
        }
        return new dArray(merged);
    }
    public function join(separator:String):String {
        if (separator == undefined || separator == null) separator = ",";
        return _data.join(separator);
    }
    public function reverse():dArray { _data.reverse(); return this; }
    public function sort(compareFn:Function):dArray {
        if (compareFn == undefined || compareFn == null) {
            _data.sort();
        } else {
            _data.sort(compareFn);
        }
        return this;
    }
    public function toArray():Array { return _data.slice(); }
    public function toString():String { return _data.toString(); }
	
    public static function install():Void {
        if (Array.prototype.__dArrayInstalled__) return;
        Array.prototype.__dArrayInstalled__ = true;
        var _se:Function = function(a, b):Boolean {
            if (typeof(a) !== typeof(b)) return false;
            return a === b;
        };

        var _ri:Function = function(len:Number, fromIndex):Number { // rfi
            if (fromIndex == undefined || fromIndex == null) return 0;
            if (fromIndex < 0) return Math.max(0, len + fromIndex);
            return fromIndex;
        };

        var _fn:Function; // fn
        _fn = function(arr:Array, depth:Number):Array {
            var out:Array = [];
            for (var i:Number = 0; i < arr.length; i++) {
                if (depth > 0 && arr[i] instanceof Array) {
                    var inner:Array = _fn(arr[i], depth - 1);
                    for (var j:Number = 0; j < inner.length; j++) out.push(inner[j]);
                } else {
                    out.push(arr[i]);
                }
            }
            return out;
        };//some stuff after all of this are referenced from avm2 rep. took mechanics from caurina to help me to do stuff
        Array.prototype.eitherHas = function(value):Boolean {
            for (var i:Number = 0; i < this.length; i++) {
                if (_se(this[i], value)) return true;
            }
            return false;
        };
        Array.prototype.includes = function(searchElement, fromIndex:Number):Object {
            var start:Number = _ri(this.length, fromIndex);
            for (var i:Number = start; i < this.length; i++) {
                if (_se(this[i], searchElement)) return { found: true, index: i };
            }
            return { found: false, index: -1 };
        };
        if (Array.prototype.indexOf == undefined) {
            Array.prototype.indexOf = function(searchElement, fromIndex:Number):Number {
                var start:Number = _ri(this.length, fromIndex);
                for (var i:Number = start; i < this.length; i++) {
                    if (_se(this[i], searchElement)) return i;
                }
                return -1;
            };
        }
        if (Array.prototype.lastIndexOf == undefined) {
            Array.prototype.lastIndexOf = function(searchElement, fromIndex:Number):Number {
                var start:Number;
                if (fromIndex == undefined || fromIndex == null) {
                    start = this.length - 1;
                } else {
                    start = fromIndex < 0
                        ? Math.max(0, this.length + fromIndex)
                        : Math.min(fromIndex, this.length - 1);
                }
                for (var i:Number = start; i >= 0; i--) {
                    if (_se(this[i], searchElement)) return i;
                }
                return -1;
            };
        }
        Array.prototype.every = function(callbackFn:Function, thisObj:Object):Boolean {
            for (var i:Number = 0; i < this.length; i++) {
                if (!callbackFn.call(thisObj, this[i], i, this)) return false;
            }
            return true;
        };
        Array.prototype.some = function(callbackFn:Function, thisObj:Object):Boolean {
            for (var i:Number = 0; i < this.length; i++) {
                if (callbackFn.call(thisObj, this[i], i, this)) return true;
            }
            return false;
        };
        Array.prototype.filter = function(callbackFn:Function, thisObj:Object):Array {
            var result:Array = [];
            for (var i:Number = 0; i < this.length; i++) {
                if (callbackFn.call(thisObj, this[i], i, this)) result.push(this[i]);
            }
            return result;
        };
        Array.prototype.map = function(callbackFn:Function, thisObj:Object):Array {
            var result:Array = [];
            for (var i:Number = 0; i < this.length; i++) {
                result.push(callbackFn.call(thisObj, this[i], i, this));
            }
            return result;
        };
        Array.prototype.forEach = function(callbackFn:Function, thisObj:Object):Void {
            for (var i:Number = 0; i < this.length; i++) {
                callbackFn.call(thisObj, this[i], i, this);
            }
        };
        Array.prototype.find = function(callbackFn:Function, thisObj:Object) {
            for (var i:Number = 0; i < this.length; i++) {
                if (callbackFn.call(thisObj, this[i], i, this)) return this[i];
            }
            return undefined;
        };
        Array.prototype.findIndex = function(callbackFn:Function, thisObj:Object):Number {
            for (var i:Number = 0; i < this.length; i++) {
                if (callbackFn.call(thisObj, this[i], i, this)) return i;
            }
            return -1;
        };
        Array.prototype.flat = function(depth:Number):Array {
            if (depth == undefined || depth == null) depth = 1;
            return _fn(this, depth);
        };
        Array.prototype.fill = function(value, start:Number, end:Number):Array {
            var len:Number = this.length;
            if (start == undefined || start == null) start = 0;
            if (end   == undefined || end   == null) end   = len;
            if (start < 0) start = Math.max(0, len + start);
            if (end   < 0) end   = Math.max(0, len + end);
            for (var i:Number = start; i < end && i < len; i++) this[i] = value;
            return this;
        };
        Array.prototype.at = function(index:Number) {
            if (index < 0) index = this.length + index;
            return this[index];
        };
        Array.prototype.copyWithin = function(target:Number, start:Number, end:Number):Array {
            var len:Number = this.length;
            if (start == undefined || start == null) start = 0;
            if (end   == undefined || end   == null) end   = len;
            target = target < 0 ? Math.max(0, len + target) : Math.min(target, len);
            start  = start  < 0 ? Math.max(0, len + start)  : Math.min(start, len);
            end    = end    < 0 ? Math.max(0, len + end)     : Math.min(end, len);
            var copy:Array = this.slice(start, end);
            for (var i:Number = 0; i < copy.length && (target + i) < len; i++) {
                this[target + i] = copy[i];
            }
            return this;
        };
        Array.prototype.toArray = function():Array {
            return this.slice();
        };
    }
    private function _strictEqual(a, b):Boolean {
        if (typeof(a) !== typeof(b)) return false;
        return a === b;
    }
    private function _resolveFromIndex(fromIndex:Number):Number {
        if (fromIndex == undefined || fromIndex == null) return 0;
        if (fromIndex < 0) {
            return Math.max(0, _data.length + fromIndex);
        }
        return fromIndex;
    }
    private function _flatNative(arr:Array, depth:Number):Array {
        var result:Array = [];
        for (var i:Number = 0; i < arr.length; i++) {
            if (depth > 0 && arr[i] instanceof Array) {
                var inner:Array = _flatNative(arr[i], depth - 1);
                for (var j:Number = 0; j < inner.length; j++) {
                    result.push(inner[j]);
                }
            } else {
                result.push(arr[i]);
            }
        }
        return result;
    }
}

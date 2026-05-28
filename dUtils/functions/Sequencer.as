class dUtils.functions.Sequencer {

	private static var _steps:Array       = [];
	private static var _index:Number      = 0;
	private static var _host:MovieClip;
	private static var _startTime:Number  = 0;
	private static var _recording:Boolean = false;

	// Sequencer.Start(host, block)
	public static function Start(host:MovieClip, block:Function):Void {
		_host      = host;
		_steps     = [];
		_index     = 0;
		_recording = true;
		block();
		_recording = false;
		_advance();
	}

	// Sequencer.Wait(ms)
	public static function Wait(ms:Number):Void {
		if (_recording) {
			_steps.push({ type:"delay", ms:ms });
		}
	}

	// Sequencer.Call(fn) / Sequencer.Call(fn, [arg1, arg2])
	public static function Call(fn:Function, args:Array):Void {
		if (_recording) {
			_steps.push({ type:"fn", fn:fn, args:(args || []) });
		} else {
			fn.apply(null, args || []);
		}
	}

	// Sequencer.Wrap(function(){ ... })
	public static function Wrap(fn:Function):Void {
		if (_recording) {
			_steps.push({ type:"fn", fn:fn, args:[] });
		} else {
			fn();
		}
	}

	// Sequencer.Repeat(n, block)
	public static function Repeat(times:Number, block:Function):Void {
		if (!_recording) return;
		var savedSteps:Array  = _steps;
		var savedIndex:Number = _index;
		_steps = [];
		block();
		var innerSteps:Array = _steps;
		_steps = savedSteps;
		_index = savedIndex;
		_steps.push({ type:"repeat", times:times, inner:innerSteps });
	}

	// Sequencer.Cancel()
	public static function Cancel():Void {
		if (_host) _host.onEnterFrame = undefined;
		_steps = [];
		_index = 0;
	}

	private static function _advance():Void {
		if (_index >= _steps.length) {
			if (_host) _host.onEnterFrame = undefined;
			return;
		}

		var step:Object = _steps[_index];
		_index++;

		switch (step.type) {
			case "fn":
				step.fn.apply(null, step.args);
				_advance();
				break;

			case "delay":
				_startTime = getTimer();
				var ms:Number = step.ms;
				_host.onEnterFrame = function():Void {
					if (getTimer() - Sequencer._startTime >= ms) {
						delete _host.onEnterFrame;
						Sequencer._advance();
					}
				};
				break;

			case "repeat":
				var counter:Object = { type:"_rtick", inner:step.inner, left:step.times };
				var expanded:Array = step.inner.concat([counter]);
				_steps = _steps.slice(0, _index).concat(expanded).concat(_steps.slice(_index));
				_advance();
				break;

			case "_rtick":
				if (step.left == -1) {
					var ins1:Array = step.inner.concat([step]);
					_steps = _steps.slice(0, _index).concat(ins1).concat(_steps.slice(_index));
					_advance();
				} else if (step.left > 1) {
					step.left--;
					var ins2:Array = step.inner.concat([step]);
					_steps = _steps.slice(0, _index).concat(ins2).concat(_steps.slice(_index));
					_advance();
				} else {
					_advance();
				}
				break;
		}
	}

}

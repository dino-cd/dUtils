# dUtils

## Array
### dArray
Array Libraries that consist of common AS3 array method to AS2 along additional content.
`indexOf` `every` `filter` `flat` `copyWithin` `splice` `eitherHas` and other methods.
```javascript
function doubleNum(item, idx, arr) {
    return typeof(item) == "number" ? item * 2 : item;
}
var doubled:dArray = da.map(doubleNum);
trace("map(doubleNum) = " + doubled.toString());
```

`import dUtils.Array.dArray`

Example of Usage:
[example](https://github.com/dino-cd/dUtils/blob/main/dUtils/Array/dmd.txt#L2).<br>
Output: [output](https://github.com/dino-cd/dUtils/blob/main/dUtils/Array/output.txt)


---
## functions
### Sequencer
Libraries to sequence actions with delays and repeats allowing dynamic usage.

```javascript
Sequencer.Start(this, function() {
	Sequencer.Call(playLevel, [id]);
	Sequencer.Wait(100);
	Sequencer.Wrap(function(){ _root.removeMovieClip("menu"); });
	Sequencer.Call(cleanup);
	Sequencer.Wrap(function(){ screen.gotoAndPlay(id); });
});
```

`import dUtils.functions.Sequencer`

Example of Usage:
[Example](https://github.com/dino-cd/dUtils/blob/main/dUtils/functions/dmd.txt#L2)

### Vector2D

Vectors Libraries that consist of `magnitude()` `magnitudeSq()` `normalize()` `addLocal(v:Vector2D)` `distanceTo(v:Vector2D)` `angle()` `rotate(rad:Number)` `lerp(v:Vector2D,t:Number)` `negateLocal()` `reflect(normal:Vector2D)` and many other functions to use!

```javascript
var a:Vector2D = new Vector2D(1, 0);
var b:Vector2D = new Vector2D(0, 1);
trace(Vector2D.angleBetweenStatic(a, b) * (180 / Math.PI));
```

`import dUtils.functions.Vector2D`

Example of Usage: [Example](https://github.com/rizalsmpeducationid/dUtils/blob/main/dUtils/functions/exVec.txt)<br>
Output: [Output](https://github.com/rizalsmpeducationid/dUtils/blob/main/dUtils/functions/exVec.txt)

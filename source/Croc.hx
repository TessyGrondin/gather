package;

import flixel.math.FlxRect;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.FlxG;
import flixel.util.FlxColor;

class Croc extends FlxSprite
{
    public var orientation:Int;
    public var left = true;
    public var right = true;
    public var up = true;
    public var down = true;
    var L1 = 0.75 * 19;
    public var l1 = 0.75 * 37;
    var L2 = 0.75 * 41;
    var l2 = 0.75 * 18;
    public var rw = 0.75 * 79;
    public var X:Float;
    public var Y:Float;

	public function new(relX:Int, relY:Int)
	{
		super(relX * 32 - ((79 - rw) / 2), relY * 32 - ((37 - l1) / 2));

    	loadGraphic(AssetPaths.croc__png, true, 79, 37);
		updateHitbox();

        scale.x = 0.75;
        scale.y = 0.75;

		this.x = relX * 32 - ((79 - rw) / 2);
		this.y = relY * 32 - ((37 - l1) / 2);

        animation.add("swim", [0, 1, 2, 3], 10, true);
        animation.play("swim");

        var ran = new FlxRandom();
        orientation = ran.int(0, 3);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        if (orientation == 0 || orientation == 2) {
            X = x;
            Y = y;
        } else {
            X = x + l1;
            Y = y - L1;
        }
        angle = orientation * 90;
        changeDirection();
        if (orientation == 0 && x - 1 > -((79 - rw) / 2) && left)
            x -= 0.5;
        else if (orientation == 1 && y - 1 > ((79 - rw) / 2) && up)
            y -= 0.5;
        else if (orientation == 2 && x + 1 + rw + ((79 - rw) / 2) < 320 && right)
            x += 0.5;
        else if (orientation == 3 && y + 1 + rw - ((79 - rw) / 2) < 480 && down)
            y += 0.5;
	}

    public function changeDirection() {
        if (!FlxG.mouse.justPressed)
            return;
        if (orientation == 0 || orientation == 2) {
            if (FlxG.mouse.x < x || FlxG.mouse.x > x + rw || FlxG.mouse.y < y || FlxG.mouse.y > y + l1)
                return;
            if (FlxG.mouse.x > x + L1 + L2 && FlxG.mouse.x < x + rw && FlxG.mouse.y > y && FlxG.mouse.y < y + l1)
                orientation = 0;
            if (FlxG.mouse.x > x + L1 && FlxG.mouse.x < x + L1 + L2 && FlxG.mouse.y > y + L1 && FlxG.mouse.y < y + l1)
                orientation = 1;
            if (FlxG.mouse.x > x && FlxG.mouse.x < x + L1 && FlxG.mouse.y > y && FlxG.mouse.y < y + l1)
                orientation = 2;
            if (FlxG.mouse.x > x + L1 && FlxG.mouse.x < x + L1 + L2 && FlxG.mouse.y > y && FlxG.mouse.y < y + l2)
                orientation = 3;
        } else {
            var nx = x + l1;
            if (FlxG.mouse.x < nx || FlxG.mouse.x > nx + l1 || FlxG.mouse.y < y - L1 || FlxG.mouse.y > y + L1 + L2)
                return;
            if (FlxG.mouse.x > nx + L1 && FlxG.mouse.x < nx + l1 && FlxG.mouse.y > y && FlxG.mouse.y < y + L2)
                orientation = 0;
            if (FlxG.mouse.x > nx && FlxG.mouse.x < nx + l1 && FlxG.mouse.y > y + L2 && FlxG.mouse.y < y + L1 + L2)
                orientation = 1;
            if (FlxG.mouse.x > nx && FlxG.mouse.x < nx + l2 && FlxG.mouse.y > y && FlxG.mouse.y < y + L2)
                orientation = 2;
            if (FlxG.mouse.x > nx && FlxG.mouse.x < nx + l1 && FlxG.mouse.y > y - L1 && FlxG.mouse.y < y)
                orientation = 3;
        }
    }
}

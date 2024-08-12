package;

import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class Croc extends FlxSprite
{
    public var orientation:Int;
    public var left = true;
    public var right = true;
    public var up = true;
    public var down = true;
    var L1 = 0.75 * 19;
    var l1 = 0.75 * 37;
    var L2 = 0.75 * 41;
    var l2 = 0.75 * 18;
    var rw = 0.75 * 79;
    public var X:Float;
    public var Y:Float;
    public var bw:Float;
    public var bh:Float;
    var timer:FlxTimer;

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

        // timer = new FlxTimer();
		// timer.start(5, changeOrientation, 0);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        if (orientation == 0 || orientation == 2) {
            X = x + ((79 - rw) / 2);
            Y = y + ((37 - l1) / 2);
            bw = rw;
            bh = l1;
        } else {
            X = x + l1;
            Y = y - L1;
            bw = l1;
            bh = rw;
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
            if (FlxG.mouse.x < X || FlxG.mouse.x > X + rw || FlxG.mouse.y < y || FlxG.mouse.y > y + l1)
                return;
            if (FlxG.mouse.x > X + L1 + L2 && FlxG.mouse.x < X + rw && FlxG.mouse.y > y && FlxG.mouse.y < y + l1)
                orientation = 0;
            if (FlxG.mouse.x > X + L1 && FlxG.mouse.x < X + L1 + L2 && FlxG.mouse.y > y + L1 && FlxG.mouse.y < y + l1)
                orientation = 1;
            if (FlxG.mouse.x > X && FlxG.mouse.x < X + L1 && FlxG.mouse.y > y && FlxG.mouse.y < y + l1)
                orientation = 2;
            if (FlxG.mouse.x > X + L1 && FlxG.mouse.x < X + L1 + L2 && FlxG.mouse.y > y && FlxG.mouse.y < y + l2)
                orientation = 3;
        } else {
            if (FlxG.mouse.x < X || FlxG.mouse.x > X + l1 || FlxG.mouse.y < y - L1 || FlxG.mouse.y > y + L1 + L2)
                return;
            if (FlxG.mouse.x > X + L1 && FlxG.mouse.x < X + l1 && FlxG.mouse.y > y && FlxG.mouse.y < y + L2)
                orientation = 0;
            if (FlxG.mouse.x > X && FlxG.mouse.x < X + l1 && FlxG.mouse.y > y + L2 && FlxG.mouse.y < y + L1 + L2)
                orientation = 1;
            if (FlxG.mouse.x > X && FlxG.mouse.x < X + l2 && FlxG.mouse.y > y && FlxG.mouse.y < y + L2)
                orientation = 2;
            if (FlxG.mouse.x > X && FlxG.mouse.x < X + l1 && FlxG.mouse.y > y - L1 && FlxG.mouse.y < y)
                orientation = 3;
        }
    }

    public function changeOrientation(_):Void {
        var ran = new FlxRandom();
        orientation = ran.int(0, 3);
    }
}

package;

import flixel.math.FlxRect;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.FlxG;
import flixel.util.FlxColor;

class Croc extends FlxSprite
{
    public var orientation:Int;
	public function new(relX:Int, relY:Int)
	{
		super(relX * 32, relY * 32);

    	loadGraphic(AssetPaths.croc__png, true, 79, 37);
		updateHitbox();

        // scale.x = 0.75;
        // scale.y = 0.75;

		this.x = relX * 32;
		this.y = relY * 32;

        animation.add("swim", [0, 1, 2, 3], 10, true);
        animation.play("swim");

        var ran = new FlxRandom();
        orientation = ran.int(0, 3);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        angle = orientation * 90;
        changeDirection();
	}

    public function changeDirection() {
        if (!FlxG.mouse.justPressed)
            return;
        if (orientation == 0 || orientation == 2) {
            if (FlxG.mouse.x < x || FlxG.mouse.x > x + 79 || FlxG.mouse.y < y || FlxG.mouse.y > y + 37)
                return;
            if (FlxG.mouse.x > x + 60 && FlxG.mouse.x < x + 79 && FlxG.mouse.y > y && FlxG.mouse.y < y + 37)
                orientation = 0;
            if (FlxG.mouse.x > x + 19 && FlxG.mouse.x < x + 60 && FlxG.mouse.y > y + 19 && FlxG.mouse.y < y + 37)
                orientation = 1;
            if (FlxG.mouse.x > x && FlxG.mouse.x < x + 19 && FlxG.mouse.y > y && FlxG.mouse.y < y + 37)
                orientation = 2;
            if (FlxG.mouse.x > x + 19 && FlxG.mouse.x < x + 60 && FlxG.mouse.y > y && FlxG.mouse.y < y + 18)
                orientation = 3;
        } else {
            if (FlxG.mouse.x < x || FlxG.mouse.x > x + 37 || FlxG.mouse.y < y || FlxG.mouse.y > y + 79)
                return;
            if (FlxG.mouse.x > x + 19 && FlxG.mouse.x < x + 37 && FlxG.mouse.y > y + 19 && FlxG.mouse.y < y + 60)
                orientation = 0;
            if (FlxG.mouse.x > x && FlxG.mouse.x < x + 37 && FlxG.mouse.y > y + 60 && FlxG.mouse.y < y + 79)
                orientation = 1;
            if (FlxG.mouse.x > x && FlxG.mouse.x < x + 18 && FlxG.mouse.y > y + 19 && FlxG.mouse.y < y + 60)
                orientation = 2;
            if (FlxG.mouse.x > x && FlxG.mouse.x < x + 37 && FlxG.mouse.y > y && FlxG.mouse.y < y + 19)
                orientation = 3;
        }
    }
}

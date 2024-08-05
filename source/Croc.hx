package;

import flixel.FlxSprite;
import flixel.math.FlxRandom;

class Croc extends FlxSprite
{
    public var orientation:Int;

	public function new(relX:Int, relY:Int)
	{
		super(relX * 32, relY * 32);

    	loadGraphic(AssetPaths.croc__png, true, 79, 37);
		this.x = relX * 32;
		this.y = relY * 32;
		updateHitbox();

        scale.x = 0.75;
        scale.y = 0.75;

        animation.add("swim", [0, 1, 2, 3], 10, true);
        animation.play("swim");

        var ran = new FlxRandom();
        orientation = ran.int(0, 3);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        angle = orientation * 90;
	}
}

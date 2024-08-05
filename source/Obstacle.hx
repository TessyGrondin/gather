package;

import flixel.FlxSprite;

class Obstacle extends FlxSprite
{
	public function new(relX:Int, relY:Int, type:Int, reversed:Bool)
	{
		super(relX * 32, relY * 32);

        if (type == 1)
        	loadGraphic(AssetPaths.other_obstacle__png, false, 64, 96);
        else
            loadGraphic(AssetPaths.obstacle__png, false, 96, 64);
        if (reversed)
            flipX = true;
		this.x = relX * 32;
		this.y = relY * 32;
		updateHitbox();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}

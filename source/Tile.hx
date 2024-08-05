package;

import flixel.FlxSprite;

class Tile extends FlxSprite
{
	public function new(pos:Int, type:Int)
	{
		super(pos % 10 * 32, Std.int(pos / 10) * 32);

    	loadGraphic(AssetPaths.surroundings__png, true, 32, 32);
        if (type == 0)
			animation.add("wave", [5, 6, 7], 5, true);
        else {
			animation.add("wave", [13, 14, 15], 5, true);
		}
		this.x = pos % 10 * 32;
		this.y = Std.int(pos / 10) * 32;
		updateHitbox();
		animation.play("wave");
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}

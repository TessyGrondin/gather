package;

import flixel.FlxSprite;

class Obstacle extends FlxSprite
{
	var px1 = [23, 0, 21, 26, 44, 63];
	var px2 = [40, 63, 42, 37, 18, 0];
	var px3 = [70, 87, 91, 93, 51, 12, 2, 6, 50];
	public var px:Array<Int>;

	var py1 = [0, 17, 51, 79, 93, 73];
	var py2 = [0, 0, 8, 21, 47, 59, 51, 30, 16];
	public var py:Array<Int>;

	public function new(relX:Int, relY:Int, type:Int, reversed:Bool)
	{
		super(relX * 32, relY * 32);

        if (type == 1) {
        	loadGraphic(AssetPaths.other_obstacle__png, false, 64, 96);
			py = py1;
			px = px1;
		} else {
            loadGraphic(AssetPaths.obstacle__png, false, 96, 64);
			py = py2;
			px = px3;
		}
        if (reversed) {
			px = px2;
            flipX = true;
		}
		this.x = relX * 32;
		this.y = relY * 32;
		updateHitbox();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}

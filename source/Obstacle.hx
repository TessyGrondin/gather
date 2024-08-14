package;

import flixel.FlxSprite;

class Obstacle extends FlxSprite
{
	public var X:Float;
	public var Y:Float;
	public var bw:Float;
	public var bh:Float;
	public function new(relX:Int, relY:Int, reversed:Bool)
	{
		super(relX * 32, relY * 32);

        loadGraphic(AssetPaths.obstacle__png, false, 96, 64);
		this.x = relX * 32;
		this.y = relY * 32;
		scale.x = 0.75;
		bw = width * 0.75;
		bh = height;
		X = x + 8;
		Y = y;
        if (reversed) {
			angle = 90;
			y -= width / 2;
			x += width / 2;
			bh = bw;
			bw = height;
			X = x - width / 2;
			Y = y + width / 2 + 8;
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}

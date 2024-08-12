package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class EndState extends FlxState
{
	var score:FlxText;
	public var finalScore:Int;
	var tiles:Array<Tile>;

	public function new(finalScore:Int)
	{
		super();
		this.finalScore = finalScore;
	}

	override public function create()
	{
		super.create();

        tiles = new Array<Tile>();
		for (i in 0...150) {
			tiles.push(new Tile(i, 1));
			add(tiles[i]);
		}

		score = new FlxText(320 / 2 - 75, 480 / 2 - 20, 200, "Final result: " + finalScore, 20);
		add(score);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.justPressed) {
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
			{
				FlxG.switchState(new MenuState());
			});
		}
	}
}

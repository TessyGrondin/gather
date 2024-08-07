package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.FlxG;
import haxe.iterators.ArrayIterator;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var score = 0;
	var score_disp:FlxText;
	var timer:FlxTimer;
	var timer_disp:FlxText;
	var tiles:Array<Tile>;
	var obstacles:Array<Obstacle>;
	var type = [0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,1,1,1,1,0,0,0];
	var x = [3, 2, 6, 3, 7, 0, 6, 2];
	var y = [0, 3, 4, 6, 9, 11, 13, 14];
	var t = [1, 2, 2, 1, 2, 2, 1, 1];
	var rev = [false, false, false, true, false, false, true, false];
	var crocs:Array<Croc>;

	override public function create()
	{
		super.create();

		tiles = new Array<Tile>();
		for (i in 0...150) {
			tiles.push(new Tile(i, type[i]));
			add(tiles[i]);
		}

		obstacles = new Array<Obstacle>();
		for (i in 0...8) {
			obstacles.push(new Obstacle(x[i], y[i], t[i], rev[i]));
			add(obstacles[i]);
		}

		crocs = new Array<Croc>();
		for (i in 0...1) {
			crocs.push(new Croc(5, 7));
			add(crocs[i]);
		}

		timer = new FlxTimer();
		timer.start(90, change, 0);

		timer_disp = new FlxText(FlxG.width - 50, 10, 200, "" + Std.int(timer.timeLeft), 20);
		add(timer_disp);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		timer_disp.text = "" + Std.int(timer.timeLeft);

	}

	public function change(_):Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			FlxG.switchState(new EndState(1));
		});
	}
}

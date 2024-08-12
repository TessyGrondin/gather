package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
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
	var x = [3, 2, 4, 7, 0, 6, 2];
	var y = [0, 3, 6, 9, 11, 13, 14];
	var rev = [false, true, false, true, true, false, false];
	var crocs:Array<Croc>;
	var cx = [5, 4, 5, 6, 6, 2, 5, 3];
	var cy = [7, 1, 2, 4, 6, 9, 13, 4];

	override public function create()
	{
		super.create();

		tiles = new Array<Tile>();
		for (i in 0...150) {
			tiles.push(new Tile(i, type[i]));
			add(tiles[i]);
		}

		obstacles = new Array<Obstacle>();
		for (i in 0...rev.length) {
			obstacles.push(new Obstacle(x[i], y[i], rev[i]));
			add(obstacles[i]);
		}

		crocs = new Array<Croc>();
		for (i in 0...1) {
			crocs.push(new Croc(cx[i], cy[i]));
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
		for (i in 0...crocs.length) {
			for (j in 0...obstacles.length)
				if (collide(obstacles[j], crocs[i]))
					break;
		}
	}

	public function change(_):Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			FlxG.switchState(new EndState(1));
		});
	}

	function collide(obs:Obstacle, cro:Croc):Bool {
		cro.left = true;
		cro.right = true;
		cro.up = true;
		cro.down = true;
		if (obs.Y > cro.Y + cro.bh || cro.Y > obs.Y + obs.bh)
			return false;
		if (obs.X > cro.X + cro.bw || cro.X > obs.X + cro.bw)
			return false;
		if (obs.X + cro.bw >= cro.X && obs.X < cro.X)
			cro.left = false;
		if (obs.X <= cro.X + cro.bw && obs.X + cro.bw > cro.X)
			cro.right = false;
		if (obs.Y <= cro.Y + cro.bh && obs.Y + obs.bh > cro.Y)
			cro.down = false;
		if (obs.Y + obs.bh >= cro.Y && obs.Y < cro.Y)
			cro.up = false;
		return true;
	}
}


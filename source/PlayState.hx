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
	var cx = [6, 4, 5, 6, 6, 2, 5, 3];
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
		for (i in 0...cx.length) {
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
			FlxG.switchState(new EndState(computeScore()));
		});
	}

	function collide(obs:Obstacle, cro:Croc):Bool {
		var ox  = obs.X;
		var ow = obs.X + obs.bw;
		var cx = cro.nx;
		var cw = cro.X + cro.bw;
		var oy  = obs.Y;
		var oh = obs.Y + obs.bh;
		var cy = cro.ny;
		var ch = cro.Y + cro.bh;

		cro.left = true;
		cro.right = true;
		cro.up = true;
		cro.down = true;
		if (obs.Y > cro.ny + cro.bh || cro.ny > obs.Y + obs.bh)
			return false;
		if (obs.X > cro.nx + cro.bw || cro.nx > obs.X + obs.bw)
			return false;
		if (ox < cx && ow >= cx && ow < cw)
			cro.left = false;
		if (cx < ox && cw >= ox && cw < ow)
			cro.right = false;
		if (oy < cy && oh >= cy && oh < ch)
			cro.up = false;
		if (cy < oy && ch >= oy && ch < oh)
			cro.down = false;
		return true;
	}

	function allowToTurn(obs:Obstacle, cro:Croc):Void {
		if (obs.Y > cro.revY + cro.revbh || cro.revY > obs.Y + obs.bh)
			return;
		if (obs.X > cro.revX + cro.revbw || cro.revX > obs.X + obs.bw)
			return;
		if (cro.orientation == 1 || cro.orientation == 2) {
			if (obs.X + obs.bw >= cro.revX && obs.X < cro.revX)
				cro.left = false;
			if (obs.X <= cro.revX + cro.revbw && obs.X + obs.bw > cro.revX)
				cro.right = false;
		} else {
			if (obs.Y <= cro.revY + cro.revbh && obs.Y + obs.bh > cro.revY)
				cro.down = false;
			if (obs.Y + obs.bh >= cro.revY && obs.Y < cro.revY)
				cro.up = false;
		}
	}

	function computeScore():Int {
		var score = 0;

		for (i in 0...crocs.length) {
			if (contain(crocs[i]))
				score += 100;
		}
		return score;
	}

	function contain(c:Croc):Bool {
		if (c.X >= 0 && c.X + c.bw <= 128 && c.Y >= 0 && c.Y + c.bh <= 128)
			return true;
		if (c.X >= 224 && c.X + c.bw <= 320 && c.Y >= 320 && c.Y + c.bh <= 480)
			return true;
		if (c.X >= 0 && c.X + c.bw <= 96 && c.Y >= 384 && c.Y + c.bh <= 480)
			return true;
		return false;
	}
}


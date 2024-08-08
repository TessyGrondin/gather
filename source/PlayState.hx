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
	var x = [3, 2, 4, 7, 0, 6, 2];
	var y = [0, 3, 6, 9, 11, 13, 14];
	var t = [1, 2, 1, 2, 2, 1, 1];
	var rev = [false, false, true, false, false, true, false];
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
		for (i in 0...rev.length) {
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
		for (i in 0...crocs.length) {
			for (j in 0...obstacles.length)
				if (polyRect(obstacles[j], crocs[i]))
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

	function polyRect(obs:Obstacle, rec:Croc):Bool {
		var next = 0;
		var collision = false;

		for (current in 0...obs.px.length) {
			next = current + 1;
			if (next == obs.px.length)
				next = 0;
			if (lineRect(obs.px[current] + obs.x, obs.py[current] + obs.y, obs.px[next] + obs.x, obs.py[next] + obs.y, rec))
				return true;
		}
		return false;
	}

	function lineRect(p1x, p1y, p2x, p2y, rec:Croc):Bool {
		var L:Float;
		var l:Float;

		if (rec.orientation == 0 || rec.orientation == 2) {
			L = rec.rw;
			l = rec.l1;
		} else {
			L = rec.l1;
			l = rec.rw;
		}
		rec.left = lineLine(p1x, p1y, p2x, p2y, rec.X, rec.Y, rec.X, rec.Y + l);
		rec.right = lineLine(p1x, p1y, p2x, p2y, rec.X + L, rec.Y, rec.X + L, rec.Y + l);
		rec.up = lineLine(p1x, p1y, p2x, p2y, rec.X, rec.Y, rec.X + L, rec.Y);
		rec.down = lineLine(p1x, p1y, p2x, p2y, rec.X, rec.Y + l, rec.X + L, rec.Y + l);

		return (!rec.left || !rec.right || !rec.up || !rec.down);
	}

	function lineLine(p1x:Float, p1y:Float, p2x:Float, p2y:Float, p3x:Float, p3y:Float, p4x:Float, p4y:Float):Bool {
		var uA = ((p4x - p3x) * (p1y - p3y) - (p4y - p3y) * (p1x - p3x)) /
				 ((p4y - p3y) * (p2x - p1x) - (p4x - p3x) * (p2y - p1y));
		var uB = ((p2x - p1x) * (p1y - p3y) - (p2y - p1y) * (p1x - p3x)) /
				 ((p4y - p3y) * (p2x - p1x) - (p4x - p3x) * (p2y - p1y));

		if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1)
			return false;
		return true;
	}
}


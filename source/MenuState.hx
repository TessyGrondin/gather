package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.ui.FlxButtonPlus;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.display.SpreadMethod;
import openfl.display.Sprite;

class MenuState extends FlxState
{
	var title:FlxText;
	var blinkTime:Float = 0;
	var tiles:Array<Tile>;

	override public function create()
	{
		super.create();

		tiles = new Array<Tile>();
		for (i in 0...150) {
			tiles.push(new Tile(i, 1));
			add(tiles[i]);
		}

		title = new FlxText(75, 40, 200, "gather as many crocodiles as\nyou can in the clear areas", 20);
		add(title);

		var buttonPlay:FlxButtonPlus = new FlxButtonPlus(0, 0, function()
		{
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
			{
				FlxG.switchState(new PlayState());
			});
		}, "PLAY", 176, 32);
		buttonPlay.x = FlxG.width / 2 - buttonPlay.width / 2;
		buttonPlay.y = FlxG.height / 2 - buttonPlay.height / 2 + 30;
		buttonPlay.textNormal.y = buttonPlay.y + 10;
		buttonPlay.textHighlight.y = buttonPlay.y + 10;
		add(buttonPlay);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}

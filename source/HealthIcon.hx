package;

import flixel.FlxSprite;
import StringTools;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);

		animation.add('bf', [0, 1], 0, false, isPlayer);
		animation.add('bf-car', [0, 1], 0, false, isPlayer);
		animation.add('bf-hell', [0, 1], 0, false, isPlayer);
		animation.add('bf-christmas', [0, 1], 0, false, isPlayer);
		animation.add('bf-pixel', [21, 21], 0, false, isPlayer);
		animation.add('spooky', [2, 3], 0, false, isPlayer);
		animation.add('pico', [4, 5], 0, false, isPlayer);
		animation.add('mom', [6, 7], 0, false, isPlayer);
		animation.add('mom-car', [6, 7], 0, false, isPlayer);
		animation.add('tankman', [8, 9], 0, false, isPlayer);
		animation.add('face', [10, 11], 0, false, isPlayer);
		animation.add('dad', [12, 13], 0, false, isPlayer);
		animation.add('senpai', [22, 22], 0, false, isPlayer);
		animation.add('senpai-angry', [22, 22], 0, false, isPlayer);
		animation.add('spirit', [23, 23], 0, false, isPlayer);
		animation.add('bf-old', [14, 15], 0, false, isPlayer);
		animation.add('gf', [16], 0, false, isPlayer);
		animation.add('monster', [19, 20], 0, false, isPlayer);
		animation.add('monster-christmas', [19, 20], 0, false, isPlayer);

		animation.add('garcello', [24, 25], 0, false, isPlayer);
		animation.add('garcellotired', [26, 27], 0, false, isPlayer);
		animation.add('garcellodead', [28, 29], 0, false, isPlayer);
		animation.add('garcelloghosty', [29, 29], 0, false, isPlayer);
		animation.add('parents-christmas', [17], 0, false, isPlayer);

		animation.add('whitty', [30, 31], 0, false, isPlayer);
		animation.add('whittyCrazy', [32, 33], 0, false, isPlayer);

		animation.add('kapi', [34, 35], 0, false, isPlayer);
		animation.add('kapi-angry', [36, 35], 0, false, isPlayer);
		animation.add('mrgame', [37, 38], 0, false, isPlayer);

		animation.add('trickyMask', [39, 40], 0, false, isPlayer);
		animation.add('tricky', [41, 42], 0, false, isPlayer);
		animation.add('exTricky', [43, 44], 0, false, isPlayer);
		animation.add('trickyH', [45, 46], 0, false, isPlayer);

		animation.add('tord', [47, 48], 0, false, isPlayer);
		animation.add('tordbot', [49, 50], 0, false, isPlayer);

		animation.add('agoti', [51, 52], 0, false, isPlayer);
		animation.add('agoti-micless', [51, 52], 0, false, isPlayer);
		animation.add('agoti-crazy', [53, 52], 0, false, isPlayer);

		animation.play(char);

		antialiasing = !(char == "senpai" || char == "senpai-angry" || char == "spirit");

		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}

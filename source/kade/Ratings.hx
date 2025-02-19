package kade;

import flixel.FlxG;

class Ratings
{
	public static function CalculateRating(noteDiff:Float, ?customSafeZone:Float):String // Generate a judgement through some timing shit
	{
		var customTimeScale = Conductor.timeScale;

		if (customSafeZone != null)
			customTimeScale = customSafeZone / 166;

		// trace(customTimeScale + ' vs ' + Conductor.timeScale);

		// I HATE THIS IF CONDITION
		// IF LEMON SEES THIS I'M SORRY :(

		// trace('Hit Info\nDifference: ' + noteDiff + '\nZone: ' + Conductor.safeZoneOffset * 1.5 + "\nTS: " + customTimeScale + "\nLate: " + 155 * customTimeScale);

		if (FlxG.save.data.botplay)
			return "good"; // FUNNY

		if (noteDiff > 166 * customTimeScale) // so god damn early its a miss
			return "miss";
		if (noteDiff > 135 * customTimeScale) // way early
			return "shit";
		else if (noteDiff > 90 * customTimeScale) // early
			return "bad";
		else if (noteDiff > 45 * customTimeScale) // your kinda there
			return "good";
		else if (noteDiff < -45 * customTimeScale) // little late
			return "good";
		else if (noteDiff < -90 * customTimeScale) // late
			return "bad";
		else if (noteDiff < -135 * customTimeScale) // late as fuck
			return "shit";
		else if (noteDiff < -166 * customTimeScale) // so god damn late its a miss
			return "miss";
		return "sick";
	}

	public static function CalculateRanking(score:Int, health:Float, accuracy:Float):String
	{
		return ((FlxG.save.data.scoreDisplay ? 'Score: $score' : "") + // Score
			(FlxG.save.data.healthDisplay ? (" | Health: " + Std.int(health / 2 * 100) + "%") : "") + // Health
			(FlxG.save.data.accuracyDisplay ? " | Accuracy: "
				+ (accuracy == 0 ? "N/A" : Std.int(HelperFunctions.truncateFloat(accuracy, 2)) + " %") : "")); // Accuracy																	// 	Letter Rank
	}
}

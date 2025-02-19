package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
#if mobile
import mobile.MobileButton;
#end

using StringTools;

class StoryMenuState extends MusicBeatState
{
	var scoreText:FlxText;

	var weekData:Array<Dynamic> = [
		['Tutorial'],
		#if !MOD_ONLY
		['Bopeebo', 'Fresh', 'Dadbattle'], ['Spookeez', 'South', "Monster"], ['Pico', 'Philly', "Blammed"], ['Satin-Panties', "High", "Milf"],
		['Cocoa', 'Eggnog', 'Winter-Horrorland'], ['Senpai', 'Roses', 'Thorns'],
		#end
		['Ugh', 'Guns', 'Stress'],
		['Headache', 'Nerves', 'Release', 'Fading'],
		['Lo-fight', 'Overhead', 'Ballistic'],
		['Wocky', 'Beathoven', 'Hairball', 'Nyaw'],
		['Flatzone'],
		['Improbable-Outset', 'Madness', 'Hellclown'],
		['Norway', 'Tordbot'],
		['Screenplay', 'Parasite', 'A.G.O.T.I'],
	];
	var curDifficulty:Int = 1;

	var weekCharacters:Array<Dynamic> = [
		['', 'bf', 'gf'],
		#if !MOD_ONLY
		['dad', 'bf', 'gf'], ['spooky', 'bf', 'gf'], ['pico', 'bf', 'gf'], ['mom', 'bf', 'gf'], ['parents-christmas', 'bf', 'gf'], ['senpai', 'bf', 'gf'],
		#end
		['tankman', 'bf', 'gf'],
		['garcello', 'bf', 'gf'],
		['whitty', 'bf', 'gf'],
		['kapi', '', ''],
		['mrgame', '', ''],
		['trickyMask', 'bf', 'gf'],
		['tord', 'bf', 'gf'],
		['agoti', 'bf', 'gf']
	];

	var weekNames:Array<String> = [
		"",
		#if !MOD_ONLY
		"Daddy Dearest", "Spooky Month", "PICO", "MOMMY MUST MURDER", "RED SNOW", "hating simulator ft. moawling",
		#end
		"Tankman",
		"SMOKE 'EM OUT STRUGGLE",
		"Back Alley Blitz",
		"B-B-BREAK DOWN!",
		"Please nerf up-b...",
		"Madness",
		"Tord",
		"Prisoner of the Void",
	];

	var txtWeekTitle:FlxText;

	var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	#if mobile
	var upArrow:MobileButton;
	var downArrow:MobileButton;
	#end

	var yellowBG:FlxSprite;

	override function create()
	{
		#if NO_PRELOAD_ALL
		LoadingState.unloadAll();
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing && PlayState.SONG.song.toLowerCase() != 'fading')
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		scoreText = new FlxText(10, 10, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("VCR OSD Mono", 32);

		txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alpha = 0.7;

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("vcr.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		yellowBG = new FlxSprite(0, 56).makeGraphic(FlxG.width, 400, 0xFFF9CF51);

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);

		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);
		add(blackBarThingie);

		grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();

		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		for (i in 0...weekData.length)
		{
			var weekThing:MenuItem = new MenuItem(0, yellowBG.y + yellowBG.height + 10, #if !MOD_ONLY i #else i == 0 ? i : i + 6 #end);
			weekThing.y += ((weekThing.height + 20) * i);
			weekThing.targetY = i;
			grpWeekText.add(weekThing);

			weekThing.screenCenter(X);
			weekThing.antialiasing = true;
			// weekThing.updateHitbox();

			// Needs an offset thingie
			if (!weekUnlocked(i))
			{
				var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
				lock.frames = ui_tex;
				lock.animation.addByPrefix('lock', 'lock');
				lock.animation.play('lock');
				lock.ID = i;
				lock.antialiasing = true;
				grpLocks.add(lock);
			}
		}

		grpWeekCharacters.add(new MenuCharacter(0, 100, 0.5, false));
		grpWeekCharacters.add(new MenuCharacter(450, 25, 0.9, true));
		grpWeekCharacters.add(new MenuCharacter(850, 100, 0.5, true));

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		leftArrow = new FlxSprite(grpWeekText.members[0].x + grpWeekText.members[0].width + 10, grpWeekText.members[0].y + 10);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		leftArrow.updateHitbox();
		difficultySelectors.add(leftArrow);

		sprDifficulty = new FlxSprite(leftArrow.x + 130, leftArrow.y);
		sprDifficulty.frames = ui_tex;
		sprDifficulty.animation.addByPrefix('easy', 'EASY');
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'HARD');
		sprDifficulty.animation.play('easy');
		changeDifficulty();

		difficultySelectors.add(sprDifficulty);

		rightArrow = new FlxSprite(sprDifficulty.x + sprDifficulty.width + 50, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		rightArrow.updateHitbox();
		difficultySelectors.add(rightArrow);

		#if mobile
		downArrow = new MobileButton(grpWeekText.members[0].x + grpWeekText.members[0].width + 130, grpWeekText.members[0].y + 95, "Down", true, () -> {},
			() ->
			{
				changeWeek(1);
			});
		downArrow.scale.x = 0.8;
		downArrow.scale.y = 0.8;
		downArrow.updateHitbox();

		upArrow = new MobileButton(grpWeekText.members[0].x + grpWeekText.members[0].width, grpWeekText.members[0].y + 95, "Up", true, () -> {}, () ->
		{
			changeWeek(-1);
		});
		upArrow.scale.x = 0.8;
		upArrow.scale.y = 0.8;
		upArrow.updateHitbox();

		add(upArrow);
		add(downArrow);
		#end

		add(yellowBG);
		add(grpWeekCharacters);

		txtTracklist = new FlxText(FlxG.width * 0.05, yellowBG.x + yellowBG.height + 100, 0, "Tracks", 32);
		txtTracklist.alignment = CENTER;
		txtTracklist.font = rankText.font;
		txtTracklist.color = 0xFFe55777;
		add(txtTracklist);
		// add(rankText);
		add(scoreText);
		add(txtWeekTitle);

		updateText();

		super.create();
	}

	override function update(elapsed:Float)
	{
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5));

		scoreText.text = "WEEK SCORE:" + lerpScore;

		txtWeekTitle.text = weekNames[curWeek].toUpperCase();
		txtWeekTitle.x = FlxG.width - (txtWeekTitle.width + 10);

		// FlxG.watch.addQuick('font', scoreText.font);

		difficultySelectors.visible = weekUnlocked(curWeek);

		grpLocks.forEach(function(lock:FlxSprite)
		{
			var text = grpWeekText.members[lock.ID];
			lock.y = text.y;
			lock.visible = lock.y > yellowBG.y + yellowBG.height / 2;
		});

		var touchLeft:Bool = false;
		var touchRight:Bool = false;
		var touchSelect:Bool = false;
		#if mobile
		if (FlxG.touches.justReleased().length > 0)
		{
			touchLeft = FlxG.touches.getFirst().overlaps(leftArrow, camera);
			touchRight = FlxG.touches.getFirst().overlaps(rightArrow, camera);

			touchSelect = FlxG.touches.getFirst().overlaps(grpWeekText, camera);
		}
		#end

		if (!movedBack)
		{
			if (!selectedWeek)
			{
				if (controls.UP_P)
				{
					changeWeek(-1);
				}

				if (controls.DOWN_P)
				{
					changeWeek(1);
				}

				if (controls.RIGHT || touchRight)
					rightArrow.animation.play('press')
				else
					rightArrow.animation.play('idle');

				if (controls.LEFT || touchLeft)
					leftArrow.animation.play('press');
				else
					leftArrow.animation.play('idle');

				if (controls.RIGHT_P || touchRight)
					changeDifficulty(1);
				if (controls.LEFT_P || touchLeft)
					changeDifficulty(-1);
			}

			if (controls.ACCEPT #if mobile || touchSelect #end)
			{
				selectWeek();
			}
		}

		super.update(elapsed);
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectWeek()
	{
		if (weekUnlocked(curWeek))
		{
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));

				grpWeekText.members[curWeek].startFlashing();
				grpWeekCharacters.members[1].animation.play('bfConfirm');
				stopspamming = true;
			}

			PlayState.storyPlaylist = weekData[curWeek];
			PlayState.isStoryMode = true;
			PlayState.firstTry = true;
			selectedWeek = true;

			var diffic = "";

			switch (curDifficulty)
			{
				case 0:
					diffic = '-easy';
				case 2:
					diffic = '-hard';
			}

			PlayState.storyDifficulty = curDifficulty;

			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.storyWeek = #if !MOD_ONLY curWeek #else curWeek == 0 ? curWeek : curWeek + 6 #end;
			PlayState.campaignScore = 0;
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState(), true);
			});
		}
	}

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 2;
		if (curDifficulty > 2)
			curDifficulty = 0;

		if (#if !MOD_ONLY curWeek == 10 || curWeek == 11 #else curWeek == 4 || curWeek == 5 #end)
			curDifficulty = 2;

		sprDifficulty.offset.x = 0;

		switch (curDifficulty)
		{
			case 0:
				sprDifficulty.animation.play('easy');
				sprDifficulty.offset.x = 20;
			case 1:
				sprDifficulty.animation.play('normal');
				sprDifficulty.offset.x = 70;
			case 2:
				sprDifficulty.animation.play('hard');
				sprDifficulty.offset.x = 20;
		}

		sprDifficulty.alpha = 0;

		// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
		sprDifficulty.y = leftArrow.y - 15;
		intendedScore = Highscore.getWeekScore(#if !MOD_ONLY curWeek #else curWeek == 0 ? curWeek : curWeek + 6 #end, curDifficulty);

		FlxTween.tween(sprDifficulty, {y: leftArrow.y + 15, alpha: 1}, 0.07);
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (!weekUnlocked(curWeek) && change >= 0)
			curWeek++;
		if (!weekUnlocked(curWeek) && change < 0)
			curWeek--;

		if (curWeek >= weekData.length)
			curWeek = 0 + (change - 1);
		if (curWeek < 0)
			curWeek = weekData.length - 1;

		if (#if !MOD_ONLY curWeek == 10 || curWeek == 11 #else curWeek == 4 || curWeek == 5 #end)
		{
			curDifficulty = 2;
			changeDifficulty();
		}

		var bullShit:Int = 0;

		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && weekUnlocked(curWeek))
				item.alpha = 1;
			else
				item.alpha = 0.6;
			bullShit++;
		}

		FlxG.sound.play(Paths.sound('scrollMenu'));

		updateText();
	}

	function updateText()
	{
		grpWeekCharacters.members[0].setCharacter(weekCharacters[curWeek][0]);
		grpWeekCharacters.members[1].setCharacter(weekCharacters[curWeek][1]);
		grpWeekCharacters.members[2].setCharacter(weekCharacters[curWeek][2]);
		txtTracklist.text = "Tracks\n";

		var stringThing:Array<String> = weekData[curWeek];

		for (i in 0...stringThing.length + 1)
		{
			txtTracklist.text += "\n" + stringThing[i];
		}

		txtTracklist.text = txtTracklist.text.toUpperCase();

		txtTracklist.screenCenter(X);
		txtTracklist.x -= FlxG.width * 0.35;

		#if !switch
		intendedScore = Highscore.getWeekScore(#if !MOD_ONLY curWeek #else curWeek == 0 ? curWeek : curWeek + 6 #end, curDifficulty);
		#end
	}

	public override function onBack()
	{
		if (!movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			FlxG.switchState(new MainMenuState());
		}
	}

	public static function weekUnlocked(id:Int = 0):Bool
	{
		return id != 7;
	}
}

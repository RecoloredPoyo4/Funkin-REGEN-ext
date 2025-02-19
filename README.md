# Friday Night Funkin

**IF YOU TRY TO LAUNCH IT ON A MOBILE AND IT DOESN'T WORK, MOST OF ALL YOU DO NOT HAVE ENOUGH RAM, BECAUSE FRIDAY NIGHT FUNKIN' IS A VERY PERFORMANCE REQUIRED GAME, ESPECIALLY TRICKY MOD**

This is the repository for Friday Night Funkin REGEN ext, a game originally made for Ludum Dare 47 "Stuck In a Loop".

Play the Ludum Dare prototype here: https://ninja-muffin24.itch.io/friday-night-funkin
Play the Newgrounds one here: https://www.newgrounds.com/portal/view/770371
Support the project on the itch.io page: https://ninja-muffin24.itch.io/funkin

IF YOU MAKE A MOD AND DISTRIBUTE A MODIFIED / RECOMIPLED VERSION, YOU MUST OPEN SOURCE YOUR MOD AS WELL

## Ported mods at the moment

- [Smoke 'Em Out Struggle](https://github.com/Rageminer996/Smoke-Em-Out-Struggle-Mod)
- [Vs. Whitty](https://github.com/KadeDev/vswhitty-public)
- [VS. KAPI - Arcade Showdown](https://gamebanana.com/mods/44683)
- [The Full-Ass Tricky Mod](https://gamebanana.com/mods/44334)
- [Vs. Tord Mod REMASTERED](https://gamebanana.com/mods/183165)

## Credits / shoutouts

- [ninjamuffin99](https://twitter.com/ninja_muffin99) - Programmer
- [PhantomArcade3K](https://twitter.com/phantomarcade3k) and [Evilsk8r](https://twitter.com/evilsk8r) - Art
- [Kawaisprite](https://twitter.com/kawaisprite) - Musician
- [zatrit](https://twitter.com/zatrit) - Mod author
- [Rageminer996](https://github.com/Rageminer996) and [atsuover](https://www.youtube.com/user/EnergeticShadow) - Garcello authors
- [KadeDev](https://github.com/KadeDev) - Whitty author
- [paperkitty](https://gamebanana.com/members/1838959) - Kapi author
- Mr. Game & Watch and Flatzone are owned by Nintendo
- [Cval](https://github.com/cvalbrown) and [Rozebud](https://github.com/ThatRozebudDude) - Tricky authors
- [Bbpanzu](https://github.com/bbpanzu) and [Jason The Art Kid](https://gamebanana.com/members/1864663) - Tord authors

This game was made with love to Newgrounds and it's community. Extra love to Tom Fulp.

## Build instructions

THESE INSTRUCTIONS ARE FOR COMPILING THE GAME'S SOURCE CODE!!!

IF YOU WANT TO JUST DOWNLOAD AND INSTALL AND PLAY THE GAME NORMALLY, GO TO RELEASES AND DOWNLOAD IT

https://github.com/zatrit/Funkin-REGEN-ext/releases

IF YOU WANT TO COMPILE THE GAME YOURSELF, CONTINUE READING!!!

### Installing the Required Programs

First you need to install Haxe and HaxeFlixel. I'm too lazy to write and keep updated with that setup (which is pretty simple). 
1. [Install Haxe 4.1.5](https://haxe.org/download/version/4.1.5/) (Download 4.1.5 instead of 4.2.0 because 4.2.0 is broken and is not working with gits properly...)
2. [Install HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/) after downloading Haxe

Other installations you'd need is the additional libraries, a fully updated list will be in `Project.xml` in the project root. Currently, these are all of the things you need to install:
```
flixel
flixel-addons
flixel-ui
hscript
newgrounds
actuate
```
So for each of those type `haxelib install [library]` so shit like `haxelib install newgrounds`

You'll also need to install a couple things that involve Gits. To do this, you need to do a few things first.
1. Download [git-scm](https://git-scm.com/downloads). Works for Windows, Mac, and Linux, just select your build.
2. Follow instructions to install the application properly.
3. Run `haxelib git polymod https://github.com/larsiusprime/polymod.git` to install Polymod.
4. Run `haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc` to install Discord RPC.
5. Run `haxelib git extension-webm https://github.com/KadeDev/extension-webm` and `lime rebuild extension-webm cpp` to install Extension WebM

You should have everything ready for compiling the game! Follow the guide below to continue!

At the moment, you can optionally fix the transition bug in songs with zoomed out cameras.
- Run `haxelib git flixel-addons https://github.com/HaxeFlixel/flixel-addons` in the terminal/command-prompt.

### Compiling game for PC

Once you have all those installed, it's pretty easy to compile the game. You just need to run 'lime test html5 -debug' in the root of the project to build and run the HTML5 version. (command prompt navigation guide can be found here: [https://ninjamuffin99.newgrounds.com/news/post/1090480](https://ninjamuffin99.newgrounds.com/news/post/1090480))

To run it from your desktop (Windows, Mac, Linux) it can be a bit more involved. For Linux, you only need to open a terminal in the project directory and run 'lime test linux -debug' and then run the executable file in export/release/linux/bin. For Windows, you need to install Visual Studio Community 2019. While installing VSC, don't click on any of the options to install workloads. Instead, go to the individual components tab and choose the following:
* MSVC v142 - VS 2019 C++ x64/x86 build tools
* Windows SDK (10.0.17763.0)
* C++ Profiling tools
* C++ CMake tools for windows
* C++ ATL for v142 build tools (x86 & x64)
* C++ MFC for v142 build tools (x86 & x64)
* C++/CLI support for v142 build tools (14.21)
* C++ Modules for v142 build tools (x64/x86)
* Clang Compiler for Windows
* Windows 10 SDK (10.0.17134.0)
* Windows 10 SDK (10.0.16299.0)
* MSVC v141 - VS 2017 C++ x64/x86 build tools
* MSVC v140 - VS 2015 C++ build tools (v14.00)

This will install about 22GB of crap, but once that is done you can open up a command line in the project's directory and run `lime test windows` or `lime test windows -D MOD_ONLY` for lite version. Once that command finishes (it takes forever even on a higher end PC), you can run FNF from the .exe file under export\release\windows\bin
As for Mac, 'lime test mac -debug' should work, if not the internet surely has a guide on how to compile Haxe stuff for Mac.

### Compiling game for Android

For run it on Android, you need install:
* Android NDK (21.4.7075529)
* Android Build Tools (30.0.3)
* AdoptOpenJDK 11 (or any JDK)

Then run `lime setup android`, go to `Settings` -> `About phone` and click `Build number` several times, then go to `Settings` -> `System` -> `Developer options` and enable `USB Debugging`.
For start the game, run `lime test android` or `lime test android -D MOD_ONLY` for lite version (connect phone to PC via USB)

### Additional guides

- [Command line basics](https://ninjamuffin99.newgrounds.com/news/post/1090480)

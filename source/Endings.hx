package;

import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxG;
import flixel.FlxSprite;

class Endings extends MusicBeatState
{
    private var goodending:Bool = true; 
    public static var unlocked:Bool = false;

    override public function new(accuracy:Float)
    {
        if (accuracy > 80) {
            goodending = true;
            FlxG.save.data.secretUnlocked = true;
			FlxG.save.flush();
            trace('congrats...');
        }
        else {
            goodending = false;
        }
        super();
    }
    
    override public function create()
    {
        var bg:FlxSprite = new FlxSprite(-80);
        if (goodending) {
            bg.loadGraphic(Paths.image('konosuba/GoodEndingKO'));
        }
        else {
            bg.loadGraphic(Paths.image('konosuba/BadEndingKO'));
        }
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.setGraphicSize(Std.int(bg.width));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

        super.create();
    }

    override public function update(elapsed:Float)
    {
        if (FlxG.keys.justPressed.ENTER) {
            FlxG.sound.playMusic(Paths.music('freakyMenu'));

            transIn = FlxTransitionableState.defaultTransIn;
            transOut = FlxTransitionableState.defaultTransOut;

            FlxG.switchState(new StoryMenuState());
        }
        super.update(elapsed);
    }
}
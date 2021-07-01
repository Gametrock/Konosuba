package;

import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxG;
import flixel.FlxSprite;

class ContextScreen extends MusicBeatState
{
    private var contextDialog:Alphabet;
    private var context:Array<String> = ["Boyfriend was killed", "by tabi","once he lost in his final", "battle", "Girlfriend partly started", "looking for Boyfriend","in different places", "and this is what happened"];
    private var curDifficulty:Int = 1;
    private var selected:Int = 0;

    override public function new(diff:Int)
    {
        curDifficulty = diff;
        super();
    }
    
    override public function create()
    {
        contextDialog = new Alphabet(0, 0, context[0], true);
        contextDialog.screenCenter();
        contextDialog.alpha = 0;
        add(contextDialog);
        FlxTween.tween(contextDialog, {alpha: 1}, 1, {
            onComplete: function(tmn:FlxTween) {
                new FlxTimer().start(3, function(tmr:FlxTimer) {
                    selected++;
                    trace(selected);
                    if (selected > context.length - 1) {
                        PlayState.storyPlaylist = ['Chiisana Boukensha', 'Fantastic Dreamer', 'Tomorrow'];
                        PlayState.isStoryMode = true;
            
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
                        PlayState.storyWeek = 1;
                        PlayState.campaignScore = 0;
                        LoadingState.loadAndSwitchState(new PlayState(), true);
                        return;
                    }
                    
                    FlxTween.tween(contextDialog, {alpha: 0}, 1, {
                        onComplete: function(tmn:FlxTween) {
                            remove(contextDialog);
                            contextDialog = new Alphabet(0, 0, context[selected], true);
                            contextDialog.screenCenter();
                            contextDialog.alpha = 0;
                            add(contextDialog);
                            FlxTween.tween(contextDialog, {alpha: 1}, 1);
                        }
                    });
                }, context.length);
            }
        });
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ANY) {
            FlxTween.tween(contextDialog, {alpha: 0}, 1, {
                onComplete: function(tmn:FlxTween) {
                    PlayState.storyPlaylist = ['Chiisana Boukensha', 'Fantastic Dreamer', 'Tomorrow'];
                    PlayState.isStoryMode = true;
        
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
                    PlayState.storyWeek = 1;
                    PlayState.campaignScore = 0;
                    LoadingState.loadAndSwitchState(new PlayState(), true);
                }
            });
        }
    }
}
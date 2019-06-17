package flixel;

import flash.Lib;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flixel.graphics.tile.FlxDrawBaseItem;
import flixel.system.FlxSplash;
import flixel.util.FlxArrayUtil;
import openfl.Assets;
import openfl.filters.BitmapFilter;

@:allow(flixel.FlxG)
class FlxGame extends Sprite {
	/**
	 * Framerate to use on focus lost. Default is `10`.
	 */
	public var focusLostFramerate:Int = 10;

	/**
	 * Time in milliseconds that has passed (amount of "ticks" passed) since the game has started.
	 */
	public var ticks(default, null):Int = 0;

	/**
	 * Total number of milliseconds elapsed since game start.
	 */
	var _total:Int = 0;

	/**
	 * Time stamp of game startup. Needed on JS where `Lib.getTimer()`
	 * returns time stamp of current date, not the time passed since app start.
	 */
	var _startTime:Int = 0;

	/**
	 * Total number of milliseconds elapsed since last update loop.
	 * Counts down as we step through the game loop.
	 */
	var _accumulator:Float;

	/**
	 * Milliseconds of time since last step.
	 */
	var _elapsedMS:Float;

	/**
	 * Milliseconds of time per step of the game loop. e.g. 60 fps = 16ms.
	 */
	var _stepMS:Float;

	/**
	 * Optimization so we don't have to divide step by 1000 to get its value in seconds every frame.
	 */
	var _stepSeconds:Float;

	/**
	 * Max allowable accumulation (see `_accumulator`).
	 * Should always (and automatically) be set to roughly 2x the stage framerate.
	 */
	var _maxAccumulation:Float;

	/**
	 * Instantiate a new game object.
	 *
	 * @param GameWidth       The width of your game in game pixels, not necessarily final display pixels (see `Zoom`).
	 *                        If equal to `0`, the window width specified in the `Project.xml` is used.
	 * @param GameHeight      The height of your game in game pixels, not necessarily final display pixels (see `Zoom`).
	 *                        If equal to `0`, the window height specified in the `Project.xml` is used.
	 * @param InitialState    The class name of the state you want to create and switch to first (e.g. `MenuState`).
	 * @param Zoom            The default level of zoom for the game's cameras (e.g. `2` = all pixels are now drawn at 2x).
	 * @param UpdateFramerate How frequently the game should update (default is `60` times per second).
	 * @param DrawFramerate   Sets the actual display / draw framerate for the game (default is `60` times per second).
	 * @param SkipSplash      Whether you want to skip the flixel splash screen with `FLX_NO_DEBUG`.
	 * @param StartFullscreen Whether to start the game in fullscreen mode (desktop targets only).
	 */
	public function new(GameWidth:Int = 0, GameHeight:Int = 0, ?InitialState:Class<FlxState>, Zoom:Float = 1, UpdateFramerate:Int = 60,
			DrawFramerate:Int = 60, SkipSplash:Bool = false, StartFullscreen:Bool = false) {
		super();

		// Basic display and update setup stuff
		FlxG.init(this, GameWidth, GameHeight, Zoom);

		FlxG.updateFramerate = UpdateFramerate;
		FlxG.drawFramerate = DrawFramerate;
		_accumulator = _stepMS;

		// Then get ready to create the game object for real
		_initialState = (InitialState == null) ? FlxState : InitialState;

		addEventListener(Event.ADDED_TO_STAGE, create);
	}

	/**
	 * Used to instantiate the guts of the flixel game object once we have a valid reference to the root.
	 */
	function create(_):Void {
		if (stage == null)
			return;

		removeEventListener(Event.ADDED_TO_STAGE, create);

		_startTime = getTimer();
		_total = getTicks();

		// Finally, set up an event for the actual game loop stuff.
		stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	/**
	 * Handles the `onEnterFrame` call and figures out how many updates and draw calls to do.
	 */
	function onEnterFrame(_):Void {
		ticks = getTicks();
		_elapsedMS = ticks - _total;
		_total = ticks;

		_accumulator += _elapsedMS;
		_accumulator = (_accumulator > _maxAccumulation) ? _maxAccumulation : _accumulator;

		while (_accumulator >= _stepMS) {
			update();
			_accumulator -= _stepMS;
		}

		draw();
	}

	/**
	 * This function is called by `step()` and updates the actual game state.
	 * May be called multiple times per "frame" or draw call.
	 */
	function update():Void {
		if (!_state.active || !_state.exists)
			return;

		updateElapsed();

		updateInput();

		#if FLX_POST_PROCESS
		if (postProcesses[0] != null)
			postProcesses[0].update(FlxG.elapsed);
		#end

		_state.tryUpdate(FlxG.elapsed);
	}

	function updateElapsed():Void {
		FlxG.elapsed = FlxG.timeScale * _stepSeconds; // fixed timestep
	}

	private function updateInput():Void {
		// input
	}

	/**
	 * Goes through the game state and draws all the game objects and special effects.
	 */
	private function draw():Void {
		if (!_state.visible || !_state.exists)
			return;

		_state.draw();
	}

	inline function getTicks() {
		return getTimer() - _startTime;
	}

	dynamic function getTimer():Int {
		// expensive, only call if necessary
		return Lib.getTimer();
	}
}

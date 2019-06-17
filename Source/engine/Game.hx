package engine;

import openfl.Lib;
import openfl.events.Event;
import openfl.display.Sprite;
import engine.entities.Scene;
import engine.util.SceneManager;
import engine.GameConfigInterface;
import game.Config;

class Game extends Sprite {
	private var sceneManager:SceneManager;
	private var startTime:Int;
	private var elapsed:Float;
	private var lag:Float;
	private var maxAccumulation:Float;
	private var ticks:Int;
	private var totalTicks:Int;
	private var elapsedTime:Float;
	private var timeScale:Int = 1000;

	public var config:GameConfigInterface;
	public var scene:Scene;
	public var fps:Float;

	public function new() {
		super();
		this.config = new Config();
		this.sceneManager = new SceneManager(this);
		this.fps = 1000 / this.config.graphics.fps;

		addEventListener(Event.ADDED_TO_STAGE, this.init);
	}

	private function init(_) {
		// remove event once initialized
		removeEventListener(Event.ADDED_TO_STAGE, this.init);

		this.startTime = Lib.getTimer();
		this.totalTicks = this.getTicks();
		this.lag = 0;

		this.sceneManager.initScenes();

		addEventListener(Event.ENTER_FRAME, this.loopGame);
	}

	private function loopGame(_) {
		this.ticks = this.getTicks();
		this.elapsed = this.ticks - this.totalTicks;
		this.totalTicks = this.ticks;
		this.maxAccumulation = this.fps * 2;

		this.lag += this.elapsed;
		this.lag = (this.lag > this.maxAccumulation) ? this.maxAccumulation : this.lag;
		while (this.lag >= this.fps) {
			this.lag -= this.fps;
			this.elapsedTime = this.fps / this.timeScale;
			this.update(this.elapsedTime);
		}
	}

	private function update(elapsed:Float) {
		this.scene = this.sceneManager.getActiveScene();
		if (this.scene == null) {
			return;
		}
		this.scene._update(elapsed);
	}

	private inline function getTicks() {
		return Lib.getTimer() - this.startTime;
	}
}

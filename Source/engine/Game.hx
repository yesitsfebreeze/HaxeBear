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

	public var config:GameConfigInterface;
	public var scene:Scene;
	public var fps:Float;
	public var ticks:Int;
	public var totalTicks:Int;

	public function new() {
		super();
		this.config = new Config();
		this.sceneManager = new SceneManager();
		this.fps = 1000 / this.config.graphics.fps;
		this.startTime = Lib.getTimer();
		this.totalTicks = this.getTicks();
		this.lag = 0;

		this.addScenes();
		this.startGameLoop();
	}

	private function addScenes() {
		for (scene in this.config.scenes) {
			scene.init(this);
			this.sceneManager.addScene(scene);
			if (scene.active) {
				this.scene = scene;
				var sceneName:String = this.sceneManager.getNameFromScene(scene);
				this.sceneManager.activate(sceneName);
			}
		}
	}

	private function startGameLoop() {
		addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
	}

	private function onEnterFrame(event:Event) {
		this.ticks = this.getTicks();
		this.elapsed = this.ticks - totalTicks;
		this.totalTicks = this.ticks;

		this.lag += this.elapsed;

		while (this.lag >= this.fps) {
			this.lag -= this.fps;
			this.update(this.fps / 1000);
		}
	}

	private function update(elapsed:Float) {
		this.scene = this.sceneManager.getActiveScene();
		if (this.scene == null) {
			return;
		}
		this.scene._update(elapsed);
	}

	private function getTicks() {
		return Lib.getTimer() - this.startTime;
	}
}

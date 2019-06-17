package engine.util;

import engine.entities.Scene;
import engine.util.TypeHelper;

class SceneManager {
	private var game:Game;
	private var config:GameConfigInterface;
	private var scenes:Map<String, Scene>;
	private var activeScene:Scene;

	public function new(game) {
		this.game = game;
		this.config = game.config;
		this.scenes = new Map();
	}

	public function initScenes() {
		for (scene in this.config.scenes) {
			scene.init(this.game);
			this.addScene(scene);
			if (scene.active) {
				this.game.scene = scene;
				var sceneName:String = this.getNameFromScene(scene);
				this.activate(sceneName);
			}
		}
	}

	public function addScene(scene:Scene) {
		if (scene == null) {
			return;
		}

		this.scenes.set(this.getNameFromScene(scene), scene);
	}

	public function activate(sceneName:String) {
		if (this.activeScene != null) {
			this.deactivate(this.getNameFromScene(this.activeScene));
		}
		var scene:Scene = this.scenes.get(sceneName);
		if (scene == null) {
			return;
		}

		scene.activate();
		this.activeScene = scene;
	}

	public function deactivate(sceneName:String) {
		var scene:Scene = this.scenes.get(sceneName);
		if (scene == null) {
			return;
		}

		scene.deactivate();
		this.activeScene = null;
	}

	public function getActiveScene():Scene {
		return this.activeScene;
	}

	public function getNameFromScene(scene:Scene):String {
		return TypeHelper.getClassNameFromInstance(scene);
	}
}

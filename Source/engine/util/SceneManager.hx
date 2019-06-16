package engine.util;

import engine.entities.Scene;
import engine.util.TypeHelper;

class SceneManager {
	private var scenes:Map<String, Scene>;
	private var activeScene:Scene;

	public function new() {
		this.scenes = new Map();
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

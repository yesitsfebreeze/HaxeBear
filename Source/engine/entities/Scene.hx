package engine.entities;

import nape.space.Space;
import openfl.display.Sprite;
import engine.entities.Entity;
import game.Config;

class Scene extends Entity {
	public var active:Bool = false;
	public var space:Space = null;

	override public function new(active:Bool = false) {
		super(null);
		this.active = active;
	}

	override public function onInit() {
		this.inputManager = new InputManager(this.game);
		this.width = this.config.graphics.width;
		this.height = this.config.graphics.height;
	}

	override public function _update(elapsed:Float) {
		if (!this.active) {
			return;
		}

		super._update(elapsed);
	}

	public function activate() {
		this.active = true;
		this._create();
	}

	public function deactivate() {
		this.active = false;
		this._destroy();
	}

	public function isActive() {
		return this.active;
	}
}

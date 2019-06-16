package engine.entities;

import game.Config;
import nape.geom.Vec2;
import nape.space.Space;

class PhysicsScene extends Scene {
	override public function onInit() {
		this.initNape();
	}

	private function initNape() {
		this.space = new Space(new Vec2(this.config.physics.gravity.x, this.config.physics.gravity.y));
	}

	override public function update(elapsed:Float) {
		this.space.step(elapsed, this.config.physics.iterations.velocity, this.config.physics.iterations.position);
		super.update(elapsed);
	}
}

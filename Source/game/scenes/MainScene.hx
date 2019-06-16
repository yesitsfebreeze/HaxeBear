package game.scenes;

import engine.entities.PhysicsScene;
import game.entities.TestEntity;

class MainScene extends PhysicsScene {
	override public function create() {
		this.addEntity(new TestEntity(this));
	}
}

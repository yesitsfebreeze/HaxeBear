package game.entities;

import engine.entities.PhysicsEntity;

class TestEntity extends PhysicsEntity {
	private var posX:Int = 0;
	private var posY:Int = 0;

	override public function create() {
		super.create();
		this.draw();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		this.draw();
	}

	private function draw() {
		this.graphics.clear();
		this.graphics.beginFill(0xFF0000);
		this.graphics.drawRect(this.x, this.y, 50, 50);
	}
}

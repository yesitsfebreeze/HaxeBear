package engine.entities;

import nape.geom.Vec2;
import nape.phys.Material;
import nape.shape.Polygon;
import nape.phys.BodyType;
import nape.phys.Body;

class PhysicsEntity extends Entity {
	public var body:Body;
	public var shape:Polygon;

	override public function create() {
		super.create();
		this.body = new Body();
		this.shape = new Polygon(Polygon.box(50, 50));
		this.shape.body = this.body;
		this.body.setShapeMaterials(Material.rubber());
		this.body.shapes.add(this.shape);
		this.body.space = this.game.scene.space;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		this.x = this.body.position.x;
		this.y = this.body.position.y;
	}
}

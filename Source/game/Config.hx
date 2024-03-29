package game;

import engine.entities.Scene;
import engine.GameConfigInterface;
import game.scenes.MainScene;

class Config implements GameConfigInterface {
	public function new() {}

	public var graphics:GraphicsConfig = {
		fps: 60,
		width: 1024,
		height: 768,
	}

	public var physics:PhysicsConfig = {
		gravity: {
			x: 0,
			y: 3000,
		},
		iterations: {
			velocity: 25,
			position: 25,
		}
	};

	public var scenes:Array<Scene> = [new MainScene(true),];
}

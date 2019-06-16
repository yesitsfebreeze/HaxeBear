package engine;

import engine.entities.Scene;
import game.scenes.MainScene;

typedef GraphicsConfig = {
	fps:Int,
	width:Int,
	height:Int,
}

typedef PhysicsGravityConfig = {
	x:Int,
	y:Int,
}

typedef PhysicsIterationConfig = {
	velocity:Int,
	position:Int,
}

typedef PhysicsConfig = {
	gravity:PhysicsGravityConfig,
	iterations:PhysicsIterationConfig,
}

interface GameConfigInterface {
	/**
	 * Graphics
	 */
	public var graphics:GraphicsConfig;

	/**
	 * Physics
	 */
	public var physics:PhysicsConfig;

	/**
	 * Scenes
	 */
	public var scenes:Array<Scene>;
}

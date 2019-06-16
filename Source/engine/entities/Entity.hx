package engine.entities;

import openfl.display.Sprite;
import engine.Game;
import engine.GameConfigInterface;

class Entity extends Sprite {
	private var parentEntity:Entity;
	private var entities:Array<Entity>;
	private var game:Game;
	private var config:GameConfigInterface;

	/***
	 * @param parentEntity
	 */
	override public function new(?parentEntity:Entity = null) {
		super();
		if (parentEntity != null) {
			this.parentEntity = parentEntity;
		}

		this.entities = new Array();
	}

	/**
	 * used to set the main game sprite
	 *
	 * @param game
	 */
	public function init(game:Game) {
		this.game = game;
		this.config = game.config;
		this.onInit();
		this.game.addChild(this);
	}

	/**
	 * method to override after the entity is initialized
	 */
	public function onInit() {}

	/**
	 * used to add child entities
	 *
	 * @param entity
	 */
	public function addEntity(entity:Entity) {
		if (entity == null) {
			return;
		}

		entity.init(this.game);
		this.entities.push(entity);
	}

	/**
	 * used to initialize the entity
	 */
	public function _create() {
		this.create();
		for (entity in this.entities) {
			entity._create();
		}
	}

	/**
	 * used to initialize the entity when overriding
	 */
	public function create() {}

	/**
	 * used to update the entity
	 */
	public function _update(elapsed:Float) {
		for (entity in this.entities) {
			entity._update(elapsed);
		}
		this.update(elapsed);
	}

	/**
	 * used to update the entity when overriding
	 */
	public function update(elapsed:Float) {}

	/**
	 * used to destroy the entity
	 */
	public function _destroy() {
		for (entity in this.entities) {
			entity._destroy();
		}
		this.destroy();
	}

	/**
	 * used to destroy the entity when overriding
	 */
	public function destroy() {}
}

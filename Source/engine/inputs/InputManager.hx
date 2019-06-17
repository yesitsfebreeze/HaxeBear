package engine.inputs;

import engine.Game;
import engine.GameConfigInterface;
import engine.inputs.InputSetInterface;

class InputManager {
	private var game:Game;
	private var config:GameConfigInterface;
	private var activeSet:InputSetInterface;

	public function new(game:Game) {
		this.game = game;
		this.config = game.config;
	}

	public function setInputs(set:InputSetInterface) {
		if (this.activeSet != null) {
			this.activeSet.destroy();
		}
		this.activeSet = set;
		this.activeSet.activate();
	}
}

extends Button

@onready var turn_manager: Node2D = $"../TurnManager"

func _on_pressed() -> void:
	turn_manager.iniciar_turno()

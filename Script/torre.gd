extends Node2D

@export var vida: int = 1000
@onready var label: Label = $Label

func _ready() -> void:
	label.text = str(vida)
	
func tomar_dano(valor: int):
	label.text = str(vida)
	vida -= valor
	print("Vida restante: ", vida)
	#await get_tree().create_timer(2.0).timeout
	if vida <= 0:
		queue_free()
	

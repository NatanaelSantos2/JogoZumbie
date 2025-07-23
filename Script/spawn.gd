extends Node2D

@export var cena_zumbi: PackedScene
@onready var area_spawn: Area2D = $"../Area2D"

func spawnar_zumbis(qtd: int, vida: int, forca: int):
	var shape = area_spawn.get_node("Collision").shape as RectangleShape2D
	var extents = shape.extents
	var origin = area_spawn.global_position

	for i in range(qtd):
		var zumbi = cena_zumbi.instantiate()
		zumbi.vida = vida
		zumbi.forca = forca

		var offset_x = randf_range(-extents.x, extents.x)
		var offset_y = randf_range(-extents.y, extents.y)
		zumbi.global_position = origin + Vector2(offset_x, offset_y)

		add_child(zumbi)

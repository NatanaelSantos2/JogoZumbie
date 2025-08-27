extends Node2D

@export var cena_zumbi: PackedScene
@onready var area_spawn: Area2D = $"../Area"
@onready var collision: CollisionShape2D = $"../Area/Collision"

func spawnar_zumbis(qtd: int, vida: int, forca: int):
	var shape = collision.shape as RectangleShape2D
	var extents = shape.extents
	var center_position = area_spawn.position

	for i in range(qtd):
		var zumbi = cena_zumbi.instantiate()
		zumbi.vida = vida
		zumbi.forca = forca

		var offset_x = randf_range(-extents.x, extents.x)
		var offset_y = randf_range(-extents.y, extents.y)
		zumbi.position = center_position + Vector2(offset_x, offset_y)

		add_child(zumbi)

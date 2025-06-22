extends Node2D

@export var enemy_scene: PackedScene
@onready var spawn: Node2D = $"."

@export var quantidade_spawn: int = 5

func _ready():
	spawn_enemy()

func spawn_enemy():
	for i in quantidade_spawn:
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.position = Vector2(0, i * 70)
		add_child(enemy_instance)
		print(enemy_instance)

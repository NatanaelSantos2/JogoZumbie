extends Node2D

@export var enemy_scene: PackedScene
@onready var spawn: Node2D = $"."

@export var quantidade_spawn: int = 5
@export var raio_spawn: float = 90.0 

func _ready():
	spawn_enemy()

func spawn_enemy():
	for i in quantidade_spawn:
		var enemy_instance = enemy_scene.instantiate()
		
		var angle = randf() * TAU  # TAU = 2 * PI
		var radius = randf() * raio_spawn
		var offset = Vector2(cos(angle), sin(angle)) * radius
		
		enemy_instance.position = offset
		add_child(enemy_instance)
		print(enemy_instance)

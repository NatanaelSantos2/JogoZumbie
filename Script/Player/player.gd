extends CharacterBody2D

@onready var animated: AnimatedSprite2D = $AnimatedSprite2D

@export var BULLET: PackedScene
@export var detection_range: float = 300.0

var target: Node2D = null

@onready var gun_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast: RayCast2D = $RayCast2D
@onready var reload_timer: Timer = $RayCast2D/Timer  # Certifique-se que o Timer está aqui mesmo

func _ready() -> void:
	animated.play("new_animation")

func _physics_process(delta: float) -> void:
	update_target()

	if target:
		var angle = global_position.direction_to(target.global_position).angle()
		raycast.rotation = angle
		gun_sprite.rotation = angle
		
		if raycast.enabled and raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider and collider.is_in_group("zumbis"):
				shoot()

func shoot() -> void:
	print("PEW")
	raycast.enabled = false

	if BULLET:
		var bullet = BULLET.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = raycast.global_position
		bullet.global_rotation = raycast.global_rotation

	# Inicia a recarga para permitir o próximo tiro
	if reload_timer.is_stopped():
		reload_timer.start()

func update_target():
	var zumbis = get_tree().get_nodes_in_group("zumbis")
	var closest: Node2D = null
	var min_dist = detection_range

	for z in zumbis:
		if z and z.is_inside_tree():
			var dist = global_position.distance_to(z.global_position)
			if dist < min_dist:
				closest = z
				min_dist = dist

	target = closest

func _on_timer_timeout() -> void:
	print("Recarga concluída.")
	raycast.enabled = true

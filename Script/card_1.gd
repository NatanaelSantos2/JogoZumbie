extends Node2D

@export var construction_scene: PackedScene
var is_dragging := false
var original_position := Vector2.ZERO
const SLOT_RANGE := 32.0 

func _ready():
	original_position = global_position
	set_process_input(true)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if get_global_mouse_position().distance_to(global_position) < 32:
					is_dragging = true
			else:
				if is_dragging:
					is_dragging = false
					check_drop()

	elif event is InputEventMouseMotion and is_dragging:
		global_position = get_global_mouse_position()

func check_drop():
	for slot in get_tree().get_nodes_in_group("slots"):
		if global_position.distance_to(slot.global_position) < SLOT_RANGE:
			# Verifica se o slot já tem algum filho
			if slot.get_child_count() > 0:
				global_position = original_position
				return

			var build = construction_scene.instantiate()
			slot.add_child(build)
			build.position = Vector2.ZERO  # Centraliza no slot
			queue_free()
			return

	# Se não encaixou em slot válido, volta pra mão
	global_position = original_position

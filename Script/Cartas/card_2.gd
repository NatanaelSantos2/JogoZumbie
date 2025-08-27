extends Sprite2D

@export var spawn_scene: PackedScene  # ex: res://Scene/casa.tscn, torre.tscn, etc.

var deck: Node2D
var drag_start_pos: Vector2
var is_dragging := false

func _ready() -> void:
	deck = get_parent()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and get_rect().has_point(to_local(event.position)):
				is_dragging = true
				drag_start_pos = position
				z_index = 100
			elif not event.pressed and is_dragging:
				is_dragging = false
				z_index = 0
				handle_drop()
	elif event is InputEventMouseMotion and is_dragging:
		global_position = event.position

func handle_drop() -> void:
	var slots = get_tree().get_nodes_in_group("slots")
	for slot in slots:
		if slot is Node2D:
			var rect = Rect2(slot.global_position - Vector2(50,50), Vector2(100,100))
			if rect.has_point(global_position):
				slot.place_object(spawn_scene) # pede pro slot spawnar o objeto da carta
				queue_free() # apaga a carta
				return

	# Se não caiu em slot → volta pro lugar
	deck.organize_cards()

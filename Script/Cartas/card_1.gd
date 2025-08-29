extends Sprite2D

@export var spawn_scene: PackedScene  # ex: res://Scene/casa.tscn, torre.tscn etc.

var deck: Node2D
var drag_start_pos: Vector2
var is_dragging := false

func _ready() -> void:
	deck = get_parent()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and get_rect().has_point(to_local(event.position)):
				# Iniciou arraste
				is_dragging = true
				drag_start_pos = position
				z_index = 100
			elif not event.pressed and is_dragging:
				# Soltou
				is_dragging = false
				z_index = 0
				handle_drop(event.position)
	elif event is InputEventMouseMotion and is_dragging:
		global_position = event.position

func handle_drop(global_mouse_pos: Vector2) -> void:
	# 1) Tenta soltar no slot
	var slots = get_tree().get_nodes_in_group("slots")
	for slot in slots:
		if slot is Node2D:
			var rect = Rect2(slot.global_position - Vector2(15,15), Vector2(30,30))
			if rect.has_point(global_mouse_pos):
				# Verifica se o slot está vazio (sem filhos relevantes)
				var is_empty := slot.get_child_count() == 0
				if is_empty:
					var instance = spawn_scene.instantiate()
					slot.add_child(instance)
					instance.global_position = slot.global_position
					queue_free() # carta some do deck
				else:
					deck.organize_cards() # volta pro deck
				return

	# 2) Caso não tenha slot → reorganiza no deck
	var cards := deck.get_children().filter(func(c): return c is Sprite2D)
	var sorted = cards.duplicate()
	sorted.sort_custom(func(a, b): return a.position.x < b.position.x)

	var insert_index = 0
	for i in range(sorted.size()):
		if global_mouse_pos.x > sorted[i].global_position.x:
			insert_index = i + 1

	deck.remove_child(self)
	deck.add_child(self)
	deck.move_child(self, insert_index)

	deck.organize_cards()

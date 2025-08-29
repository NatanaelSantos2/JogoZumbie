extends Node2D
@onready var button: Button = $Panel/Button
@onready var button_2: Button = $Panel/Button2
@onready var button_3: Button = $Panel/Button3
@export var hand_node_path: NodePath  # Caminho para o nó da mão (Node2D)
@export var spawn_scene: PackedScene  # Cena que será adicionada

func _on_button_pressed() -> void:
	button.disabled = true
	add_to_hand()

func _on_button_2_pressed() -> void:
	button_2.disabled = true
	add_to_hand()

func _on_button_3_pressed() -> void:
	button_3.disabled = true
	add_to_hand()

func add_to_hand() -> void:
	var hand = get_node_or_null(hand_node_path)
	if hand == null:
		print("Erro: caminho da mão não definido!")
		return
	
	# Cria uma instância da cena
	var new_card = spawn_scene.instantiate()
	hand.add_child(new_card)

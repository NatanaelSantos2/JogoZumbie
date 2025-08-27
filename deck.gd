extends Node2D

@export var spacing: float = 30.0

func _ready() -> void:
	organize_cards()
	child_order_changed.connect(organize_cards)

func organize_cards() -> void:
	var cards := get_children().filter(func(c): return c is Sprite2D)
	var count := cards.size()
	if count == 0:
		return

	var middle_index = (count - 1) / 2.0
	for i in count:
		var card: Sprite2D = cards[i]
		var target_pos = Vector2((i - middle_index) * spacing, 0)
		
		# Tween suave
		card.create_tween().tween_property(
			card, "position", target_pos, 0.25
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

extends Area2D

@export var speed: float = 600.0
@export var dano: int = 100

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("zumbis"):
		if body.has_method("receber_dano"):
			body.receber_dano(dano)
		queue_free()

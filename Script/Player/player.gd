extends CharacterBody2D

@onready var animated: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	animated.play("new_animation")

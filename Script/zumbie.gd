extends CharacterBody2D

@export var velocidade: float = 10.0
@export var distancia_ataque: float = 25

@onready var alvo: Node2D
@onready var timer: Timer = $Timer

var vida: int
var forca: int
var ob: String = "construcoes"
var pode_atacar: bool = true
@onready var animated: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated.play("run")

func _process(_delta):
	if not is_instance_valid(alvo):
		procurar_alvo_mais_proximo()
		return

	var dist = global_position.distance_to(alvo.global_position)

	if dist <= distancia_ataque:
		velocity = Vector2.ZERO
		if pode_atacar:
			atacar_alvo()
	else:
		var direcao = (alvo.global_position - global_position).normalized()
		velocity = direcao * velocidade
		move_and_slide()

func procurar_alvo_mais_proximo():
	var mais_a_frente: Node2D = null
	var maior_x = -INF
	var construcoes = get_tree().get_nodes_in_group(ob)
	
	if construcoes:
		for c in construcoes:
			if c is Node2D and c.global_position.x > maior_x:
				maior_x = c.global_position.x
				mais_a_frente = c

	alvo = mais_a_frente

func atacar_alvo():
	if alvo and alvo.has_method("tomar_dano"):
		alvo.tomar_dano(forca)
		pode_atacar = false
		timer.start()

func receber_dano(valor: int):
	vida -= valor
	print("Zumbi levou dano. Vida restante:", vida)
	if vida <= 0:
		queue_free()

func _on_timer_timeout():
	pode_atacar = true

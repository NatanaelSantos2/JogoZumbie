extends Node2D

@export var vida: int = 100
@onready var label: Label = $Label

@export var dano: int = 50
@export var max_zumbis_afetados: int = 1
@onready var area_dano: Area2D = $AreaDanoZB

func _ready() -> void:
	label.text = str(vida)
	
func tomar_dano(valor: int):
	label.text = str(vida)
	vida -= valor
	print("Vida restante: ", vida)
	#await get_tree().create_timer(2.0).timeout
	if vida <= 0:
		queue_free()

#Atira no Zumbie
func _on_timer_timeout():
	var zumbis_na_area = []
	
	for corpo in area_dano.get_overlapping_bodies():
		if corpo.is_in_group("zumbis"):
			zumbis_na_area.append(corpo)

	# Aplica dano apenas aos primeiros N zumbis
	for i in range(min(zumbis_na_area.size(), max_zumbis_afetados)):
		if zumbis_na_area[i].has_method("receber_dano"):
			zumbis_na_area[i].receber_dano(dano)

extends Node

@onready var spawner: Node2D = $"../ZumbiSpawner"
@onready var botao_turno: Button = $"../ButtonStartTurn"

var dados_turnos = {}
var turno_atual = 1

enum FaseTurno { PLANEJAMENTO, EXECUCAO, FINALIZAR }
var fase_atual: FaseTurno = FaseTurno.PLANEJAMENTO
var turno_em_andamento := false

func _ready():
	carregar_dados()
	iniciar_planejamento()

func _process(_delta):
	if fase_atual == FaseTurno.EXECUCAO:
		if spawner.get_child_count() == 0:
			finalizar_turno()

func carregar_dados():
	var file = FileAccess.open("res://Data/turnosFase1.json", FileAccess.READ)
	dados_turnos = JSON.parse_string(file.get_as_text())

func iniciar_planejamento():
	fase_atual = FaseTurno.PLANEJAMENTO
	botao_turno.disabled = false
	print("🎴 Planejamento do turno ", turno_atual)

func iniciar_turno():
	if fase_atual != FaseTurno.PLANEJAMENTO or turno_em_andamento:
		return

	turno_em_andamento = true
	fase_atual = FaseTurno.EXECUCAO
	botao_turno.disabled = true

	var dados = dados_turnos.get(str(turno_atual))
	if dados:
		spawner.spawnar_zumbis(dados["quantidade"], dados["vida"], dados["forca"])
	else:
		print("🚫 Sem dados para o turno ", turno_atual)

func verificar_fim_do_turno():
	if spawner.get_child_count() == 0 and fase_atual == FaseTurno.EXECUCAO:
		finalizar_turno()

func finalizar_turno():
	fase_atual = FaseTurno.FINALIZAR
	print("✅ Turno ", turno_atual, " finalizado")
	turno_atual += 1
	turno_em_andamento = false

	await get_tree().create_timer(1.0).timeout
	iniciar_planejamento()

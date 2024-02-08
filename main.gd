extends Node

@export var p1_points:int
@export var p2_points:int
@onready var _saver_loader = %SaverLoader

# Called when the node enters the scene tree for the first time.
func _ready():
	start_game()
	
# funcao de iniciar o jogo caso precise fazer alguma outra vez (se tiver condiçao de game over)
func start_game():
	p1_points = 0
	p2_points = 0
	$Player1.start($StartPosition1.position)
	$Player1/AnimatedSprite2D.play("P1")
	$Player2/AnimatedSprite2D.play("P2")
	$Player2/AnimatedSprite2D.flip_v = true
	$Player2.start($StartPosition2.position)
	$Ball.start($StartPositionBall.position)
	$Score1.text = "0"
	$Score2.text = "0"

# tocou em cima ou embaixo = reflete horizontalmente
func _on_level_up_touched(body):
	body.direction.y *= -1

func _on_level_down_touched(body):
	body.direction.y *= -1
	
# tocou em um player = reflete verticalmente
func _on_player_1_touched(body):
	body.direction.x *= -1
	$Ball.flip()

func _on_player_2_touched(body):
	body.direction.x *= -1
	$Ball.flip()

# tocou em um dos lados do level = da um ponto para o jogador, reseta a bola
func _on_level_left_touched(_body):
	p2_points += 1
	$Ball.death()
	print("BOLA", $Ball.position)
	$Score2.text = str(p2_points)
	$Ball.start($StartPositionBall.position)

func _on_level_right_touched(_body):
	p1_points += 1
	$Ball.death()
	$Score1.text = str(p1_points)
	$Ball.start($StartPositionBall.position)

func _on_save_button_pressed():
	_saver_loader.save_game()

func _on_load_button_pressed():
	_saver_loader.load_game()

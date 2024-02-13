extends Node

@export var p1_points:int
@export var p2_points:int
@export var ball_scene:PackedScene
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

# tocou em cima ou embaixo = reflete horizontalmente
func _on_level_up_touched(body):
	body.direction.y *= -1

func _on_level_down_touched(body):
	body.direction.y *= -1
	
# tocou em um player = reflete verticalmente
func _on_player_1_touched(body):
	body.direction.x *= -1
	if body.has_method("flip"):
		body.flip()

func _on_player_2_touched(body):
	body.direction.x *= -1
	if body.has_method("flip"):
		body.flip()

# tocou em um dos lados do level = da um ponto para o jogador, reseta a bola
func _on_level_left_touched(body):
	p2_points += 1
	$UI/InventoryP2.add(body.type)
	body.death()
	
	var new_ball = ball_scene.instantiate()
	$".".call_deferred("add_child", new_ball)
	new_ball.call_deferred("start", $StartPositionBall.position)

func _on_level_right_touched(body):
	p1_points += 1
	$UI/InventoryP1.add(body.type)
	body.death()
	
	var new_ball = ball_scene.instantiate()
	$".".call_deferred("add_child", new_ball)
	new_ball.call_deferred("start", $StartPositionBall.position)

func _on_save_button_pressed():
	_saver_loader.save_game()

func _on_load_button_pressed():
	_saver_loader.load_game()

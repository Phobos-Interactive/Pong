extends CharacterBody2D

@export var speed = 25
var direction = Vector2.ZERO

# Reinicia a bola na posiçao "pos"
func start(pos):
	position = pos
	# escolhe uma direcao aleatoria
	direction = Vector2.ZERO
	direction.x = [-1, -0.9, -0.8, -0.7, -0.6, 0.6, 0.7, 0.8, 0.9, 1].pick_random()
	direction.y = [-1, -0.9, -0.8, -0.7, -0.6, 0.6, 0.7, 0.8, 0.9, 1].pick_random()
	direction = direction.normalized() * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	velocity = direction * speed
	move_and_slide()

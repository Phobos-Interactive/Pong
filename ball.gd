extends CharacterBody2D

@export var speed = 22
var direction = Vector2.ZERO

# Reinicia a bola na posiçao "pos"
func start(pos):
	$AnimatedSprite2D.play("default")
	position = pos
	# escolhe uma direcao aleatoria
	direction = Vector2.ZERO
	direction.x = [-1, -0.9, -0.8, -0.7, -0.6, 0.6, 0.7, 0.8, 0.9, 1].pick_random()
	direction.y = [-1, -0.9, -0.8, -0.7, -0.6, 0.6, 0.7, 0.8, 0.9, 1].pick_random()
	direction = direction.normalized() * speed
	$AnimatedSprite2D.flip_h = direction.x < 0
	
func flip():
	$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
	
func death():
	$AnimatedSprite2D.play("explode")
	await $AnimatedSprite2D.animation_finished

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	velocity = direction * speed
	move_and_slide()

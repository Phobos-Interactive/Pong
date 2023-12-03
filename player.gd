extends AnimatableBody2D

@export var speed = 400
# guarda o nome da açao de mover para cima e para baixo (para poder trocar para o player 2)
@export var action_up = "up_p1"
@export var action_down = "down_p1"

signal touched

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed(action_up):
		velocity.y -= 1
	if Input.is_action_pressed(action_down):
		velocity.y += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	move_and_collide(velocity * delta)
	
# "inicia" o jogador na posicao pos
func start(pos):
	position = pos
	
# emite um sinal quando algo toca nele (no caso a bola)
func _on_area_2d_body_entered(body):
	touched.emit(body)

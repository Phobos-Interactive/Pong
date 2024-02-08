extends CharacterBody2D

@export var speed = 4
var direction = Vector2.ZERO

var _loading = true

func on_save_game(saved_data:Array[SavedData]):
	var my_data = SavedBallData.new()
	my_data.position = position
	my_data.scene_path = scene_file_path
	my_data.direction = direction
	print("posicao salva:", my_data.position)
	saved_data.append(my_data)
	
func on_before_load_game():
	print("bola deletada")
	get_parent().remove_child(self)
	queue_free()

func on_load_game(saved_data:SavedData):
	var my_data = saved_data as SavedBallData
	global_position = my_data.position
	direction = my_data.direction
	_loading = false
	print("posicao carregada:", my_data.position)
	print("posicao collision:", $CollisionShape2D.global_position)

# Reinicia a bola na posiçao "pos"
func start(pos):
	_loading = false
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
	print(position)
	if not _loading:
		velocity = direction * speed
		move_and_slide()

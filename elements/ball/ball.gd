extends CharacterBody2D

@export var speed = 22
@export var ballTypes:Array[BallType]
var direction = Vector2.ZERO
var type:BallType

var _loading = true

func on_save_game(saved_data:Array[SavedData]):
	var my_data = SavedBallData.new()
	my_data.position = self.global_position
	my_data.scene_path = scene_file_path
	my_data.direction = direction
	my_data.type = type
	saved_data.append(my_data)
	
func on_before_load_game():
	get_parent().remove_child(self)
	queue_free()

func on_load_game(saved_data:SavedData):
	var my_data = saved_data as SavedBallData
	global_position = my_data.position
	direction = my_data.direction
	type = my_data.type
	$Sprite2D.texture = type.texture
	$Sprite2D.flip_h = direction.x < 0
	$RespawnTimer.start()

# Reinicia a bola na posiçao "pos"
func start(pos):
	_loading = true
	$RespawnTimer.start()
	type = ballTypes.pick_random()
	$Sprite2D.texture = type.texture
	position = pos
	# escolhe uma direcao aleatoria
	direction = Vector2.ZERO
	direction.x = [-1, -0.9, -0.8, -0.7, -0.6, 0.6, 0.7, 0.8, 0.9, 1].pick_random()
	direction.y = [-1, -0.9, -0.8, -0.7, -0.6, 0.6, 0.7, 0.8, 0.9, 1].pick_random()
	direction = direction.normalized() * speed
	$Sprite2D.flip_h = direction.x < 0
	
func flip():
	$Sprite2D.flip_h = !$Sprite2D.flip_h
	
func death():
	get_parent().remove_child(self)
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	velocity = direction * speed
	move_and_slide()


func _on_respawn_timer_timeout():
	_loading = false

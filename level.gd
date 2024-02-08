extends Node2D

signal up_touched
signal down_touched
signal left_touched
signal right_touched

# script so para enviar os sinais de cada canto do nivel

func _on_up_body_entered(body):
	up_touched.emit(body)

func _on_down_body_entered(body):
	down_touched.emit(body)

func _on_left_body_entered(body):
	if not body._loading:
		left_touched.emit(body)

func _on_right_body_entered(body):
	right_touched.emit(body)

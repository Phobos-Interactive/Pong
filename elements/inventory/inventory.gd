class_name Inventory
extends PanelContainer

@export var slot_scene:PackedScene

func add(ball:BallType):
	var slot = slot_scene.instantiate()
	$GridContainer.add_child(slot)
	slot.display(ball)

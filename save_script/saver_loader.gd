class_name SaverLoader
extends Node

@onready var main = $"../.."
@onready var player_1 = %Player1
@onready var player_2 = %Player2

func save_game():
	var saved_game:SavedGame = SavedGame.new()
	
	saved_game.score_p1 = main.p1_points
	saved_game.score_p2 = main.p2_points
	
	saved_game.p1_pos = player_1.global_position
	saved_game.p2_pos = player_2.global_position
	
	var saved_data:Array[SavedData] = []
	get_tree().call_group("game_events", "on_save_game", saved_data)
	saved_game.saved_data = saved_data
	
	ResourceSaver.save(saved_game, "res://savegame.tres")
	
func load_game():
	var saved_game:SavedGame = load("res://savegame.tres") as SavedGame
	
	get_tree().call_group("game_events", "on_before_load_game")
	
	main.p1_points = saved_game.score_p1
	main.p2_points = saved_game.score_p2
	main.get_node("Score1").text = str(saved_game.score_p1)
	main.get_node("Score2").text = str(saved_game.score_p2)
	
	player_1.global_position = saved_game.p1_pos
	player_2.global_position = saved_game.p2_pos
	
	for item in saved_game.saved_data:
		var scene = load(item.scene_path) as PackedScene
		var restored_node = scene.instantiate()

		main.add_child(restored_node)
		
		if restored_node.has_method("on_load_game"):
			restored_node.on_load_game(item)

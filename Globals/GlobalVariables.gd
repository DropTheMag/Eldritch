extends Node

# Scene transition variables
var current_scene = "MainNode"
var transition_scene = false

var player_exit_posx = 0
var player_exit_posy = 0
var player_start_posx = 0
var player_start_posy = 0

func finish_scene_change():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "MainNode":
			current_scene = "TestHouse"
		else:
				current_scene = "MainNode"

extends Node2D

#func _process(delta):
	#change_scene()

# Level change collision
#func _on_area_2d_body_entered(body):
	#if body.is_in_group("Player"):
		#GV.transition_scene = true

#func _on_area_2d_body_exited(body):
	#if body.is_in_group("Player"):
		#GV.transition_scene = false

# Scene change logic
#func change_scene():
	#if GV.transition_scene == true:
		#if GV.current_scene == "MainNode":
			#get_tree().change_scene_to_file("res://Levels/TestHouse.tscn")
			
			#V.finish_scene_change()

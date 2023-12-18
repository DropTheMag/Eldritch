extends Node2D

@export var level_to_load : String
@export var spawnpoint_name : String
var root
var player
# Load the selected scene when player collides
func _on_load_level_area_body_entered(body):
	
	if body.is_in_group("Player") and level_to_load != null:
		root = get_tree().get_root().get_node("Controller")
		player = root.get_node("Player")
		for child in root.get_node("Level").get_children():
			child.queue_free()
		call_deferred("load_new_level")
		
func load_new_level():
	var true_level_to_load = load(level_to_load).instantiate()
	root.get_node("Level").add_child(true_level_to_load)
	print("TrueLevel: "+str(true_level_to_load.name))
	var current_level = root.get_node("Level").get_child(0)
	player.get_node("Controller").global_position = true_level_to_load.get_node(spawnpoint_name).position

extends Node2D

@export var level_to_load : String

# Load the selected scene when player collides
func _on_load_level_area_body_entered(body):
	print(level_to_load)
	if body.is_in_group("Player") and level_to_load != null:
		var root = get_tree().get_root().get_child(1)
		var player = root.get_node("Player")
		var true_level_to_load = load(level_to_load).instantiate()
		root.remove_child(root.get_node("Level"))
		true_level_to_load.name = "Level"
		root.add_child(true_level_to_load)
		player.position = Vector2(100,100)
		print(player)
		print(level_to_load)
		print(true_level_to_load)
		print(root)
		
		# Level to load is null for some reason in the test house, needs fixed!

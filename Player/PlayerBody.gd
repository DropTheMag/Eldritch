extends CharacterBody2D

const SPEED = 100

func _physics_process(delta):
	
	var HDirection = Input.get_axis("ui_left", "ui_right") * SPEED
	var VDirection = Input.get_axis("ui_up", "ui_down") * SPEED
	
	velocity = Vector2(HDirection, VDirection)

	var collision_info = move_and_collide(velocity * delta)

	if collision_info:
		var collider = collision_info.get_collider()
		if collider and collider.is_in_group("HelperBot") and not GV.gui_is_on_screen:
			var ui_scene = preload("res://UI/HelperBotTestUI.tscn")
			var ui_scene_instance = ui_scene.instantiate()
			add_child(ui_scene_instance)
			GV.gui_is_on_screen = true
			print("Collided with HelperBot!")

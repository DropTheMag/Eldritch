extends CharacterBody2D

const SPEED = 100

func _physics_process(delta):
	
	# Player controller
	var HDirection = Input.get_axis("ui_left", "ui_right") * SPEED
	var VDirection = Input.get_axis("ui_up", "ui_down") * SPEED
	
	# Move player and grab collider info
	var collision_info = move_and_collide(Vector2(HDirection, VDirection) * delta)

	# Check collider, do stuffs
	if collision_info:
		var collider = collision_info.get_collider()
		# Check if collided with HelperBot, opens dialog
		if collider.is_in_group("HelperBot") and not GV.dialog_open:
			var DialogButton = get_node("DialogButton")
			DialogButton.text = collider.dialog_sequence[randi_range(0, collider.dialog_sequence.size() - 1)]
			DialogButton.visible = true
			GV.dialog_open = true

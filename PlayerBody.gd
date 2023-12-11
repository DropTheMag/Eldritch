extends CharacterBody2D

const SPEED = 150.0

func _physics_process(delta):
	
	var HDirection = Input.get_axis("ui_left", "ui_right")
	var VDirection = Input.get_axis("ui_up", "ui_down")
	
	if HDirection:
		velocity.x = HDirection * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if VDirection:
		velocity.y = VDirection * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

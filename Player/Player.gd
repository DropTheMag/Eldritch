extends CharacterBody2D

const SPEED = 100

func _physics_process(delta):
	
	# Player controller
	var HDirection = Input.get_axis("ui_left", "ui_right") * SPEED
	if HDirection < 0:
		get_node("Character").scale.x = abs(get_node("Character").scale.x)
	if HDirection > 0:
		get_node("Character").scale.x = -abs(get_node("Character").scale.x)
	var VDirection = Input.get_axis("ui_up", "ui_down") * SPEED
	
	# Move player and grab collider info
	var collision_info = move_and_collide(Vector2(HDirection, VDirection) * delta)

func _on_dialog_collision_tracker_body_entered(body):
	if body.is_in_group("HelperBot"):
		var DialogButton = get_node("DialogButton")
		DialogButton.text = body.dialog_sequence[randi_range(0, body.dialog_sequence.size() - 1)]
		DialogButton.visible = true
		DialogButton.reset_timer()
		#GV.dialog_open = true

# Check if the player is touching a dialog initiator, open dialog, if they leave, start the timer to remove the dialog.
func _on_dialog_collision_tracker_body_exited(body):
	if body.is_in_group("HelperBot"):
		get_node("DialogButton").dialog_timer = GV.dialog_timer
		get_node("DialogButton").timer_running = true

extends CharacterBody2D

const SPEED = 100
var dialogue_initiator_collider = null

func _physics_process(delta):
	
	# Player controller
	var HDirection = Input.get_axis("ui_left", "ui_right") * SPEED
	var VDirection = Input.get_axis("ui_up", "ui_down") * SPEED
	# Change the sprites direction when going left or right
	if HDirection < 0:
		get_node("Character").scale.x = abs(get_node("Character").scale.x)
	if HDirection > 0:
		get_node("Character").scale.x = -abs(get_node("Character").scale.x)
	
	# Move player and grab collider info
	var collision_info = move_and_collide(Vector2(HDirection, VDirection) * delta)
	
	# Check if player presses "e" to advance, randomize, select, or close dialogue
	if Input.is_action_just_pressed("ui_e"):
		var DialogueButton = get_node("DialogueButton")
		if dialogue_initiator_collider:
			DialogueButton.show_random_dialogue(dialogue_initiator_collider.dialog_sequence)
		else:
			DialogueButton.close_dialogue()
			DialogueButton.reset_dialogue_timer()

# Check if player enters dialog initiator, if so, show/set dialog and reset previous timer (if running)
func _on_dialog_collision_tracker_body_entered(body):
	dialogue_initiator_collider = body
	var DialogueButton = get_node("DialogueButton")
	if dialogue_initiator_collider.is_in_group("HelperBot"):
		DialogueButton.show_random_dialogue(dialogue_initiator_collider.dialog_sequence)

# Check if the player leaves a dialog initiator, if so, start dialog closing timer
func _on_dialog_collision_tracker_body_exited(body):
	var DialogueButton = get_node("DialogueButton")
	if dialogue_initiator_collider.is_in_group("HelperBot"):
		DialogueButton.reset_dialogue_timer(true)
	dialogue_initiator_collider = null

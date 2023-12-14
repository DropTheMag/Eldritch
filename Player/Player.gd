extends CharacterBody2D

var health = 100
var speed = 100
var can_move = true

var movement_vector = Vector2()

var dialogue_initiator_collider = null

func _ready():
	# Set player initial health value
	$PlayerUI/HealthBar.value = health

func _physics_process(delta):
	
	# Player controller
	if can_move:
		movement_vector.x = Input.get_axis("ui_left", "ui_right") * speed
		movement_vector.y = Input.get_axis("ui_up", "ui_down") * speed
		# Change the sprites direction when going left or right
		if movement_vector.x < 0:
			$Character.scale.x = abs($Character.scale.x)
		elif movement_vector.x > 0:
			$Character.scale.x = -abs($Character.scale.x)
	
		# Move player and grab collider info
		var collision_info = move_and_collide(movement_vector * delta)
	
	# Set health bar, monitor player health and perform functions on it.
	$PlayerUI/HealthBar.value = health
	if health <=0:
		can_move = false
		$RespawnButton.visible = true
	
	# Check if player presses "e" to advance, randomize, select, or close dialogue
	if Input.is_action_just_pressed("ui_e"):
		var DialogueButton = $DialogueUI/DialogueButton
		if dialogue_initiator_collider:
			if dialogue_initiator_collider.is_in_group("HelperBot"):
				DialogueButton.show_random_dialogue(dialogue_initiator_collider.dialogue_sequence)
		else:
			DialogueButton.close_dialogue()
			DialogueButton.reset_dialogue_timer()

# Respawn the player at location.
func _on_respawn_button_pressed():
	$RespawnButton.visible = false
	position = Vector2(get_parent().position.x - 128, get_parent().position.y - 128)
	health = 100
	can_move = true
	
# Check if player enters dialog initiator, if so, show/set dialog and reset previous timer (if running)
func _on_dialog_collision_tracker_body_entered(body):
	dialogue_initiator_collider = body
	if dialogue_initiator_collider.is_in_group("HelperBot"):
		$DialogueUI/DialogueButton.reset_dialogue_timer()
		$DialogueUI/DialogueButton.show_random_dialogue(dialogue_initiator_collider.dialogue_sequence)

# Check if the player leaves a dialog initiator, if so, start dialog closing timer
func _on_dialog_collision_tracker_body_exited(body):
	if dialogue_initiator_collider:
		if dialogue_initiator_collider.is_in_group("HelperBot"):
			$DialogueUI/DialogueButton.reset_dialogue_timer(true)
		dialogue_initiator_collider = null

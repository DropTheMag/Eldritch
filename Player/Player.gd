extends Node2D

# Player stats and variables
@onready var player = $Body
var health = 100

@onready var health_bar = $Body/PlayerUI/HealthBar
@onready var character_sprite = $Body/Sprite

# Dialogue interaction variables
var dialogue_initiator_collider = null
@onready var dialogue_button = $Body/DialogueUI/DialogueButton

# Respawn button
@onready var respawn_button = $Body/RespawnButton

# Runs when the 
func _ready():
	# Set player initial health value
	health_bar.value = health

# Called every physics frame to process movement and more
func _physics_process(delta):
	
	# Set health bar, monitor player health and perform functions on it.
	health_bar.value = health
	if health <=0:
		player.can_move = false
		respawn_button.visible = true
	
	# Check if player presses "e" to advance, randomize, select, or close dialogue
	if Input.is_action_just_pressed("ui_e"):
		if dialogue_initiator_collider:
			if dialogue_initiator_collider.is_in_group("HelperBot"):
				dialogue_button.show_random_dialogue(dialogue_initiator_collider.dialogue_sequence)
		else:
			dialogue_button.close_dialogue()
			dialogue_button.reset_dialogue_timer()

# Respawn the player at location.
func _on_respawn_button_pressed():
	respawn_button.visible = false
	position = Vector2()
	health = 100
	player.can_move = true
	
# Check if player enters dialog initiator, if so, show/set dialog and reset previous timer (if running)
func _on_dialog_collision_tracker_body_entered(body):
	dialogue_initiator_collider = body
	if dialogue_initiator_collider.is_in_group("HelperBot"):
		dialogue_button.reset_dialogue_timer()
		dialogue_button.show_random_dialogue(dialogue_initiator_collider.dialogue_sequence)

# Check if the player leaves a dialog initiator, if so, start dialog closing timer
func _on_dialog_collision_tracker_body_exited(body):
	if dialogue_initiator_collider:
		if dialogue_initiator_collider.is_in_group("HelperBot"):
			dialogue_button.reset_dialogue_timer(true)
		dialogue_initiator_collider = null

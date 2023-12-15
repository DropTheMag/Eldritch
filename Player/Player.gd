extends Node2D

# Player stats and variables
@onready var player_controller = $Controller
var health = 100

# Preload and instantiate the PlayerUI scene and health_bar/stamina_bar to access and modify their values
@onready var player_ui = preload("res://Player/UI/PlayerUI.tscn").instantiate()
@onready var health_bar = player_ui.get_node("MarginContainer/VBoxContainer/HealthBar")
@onready var stamina_bar = player_ui.get_node("MarginContainer/VBoxContainer/StaminaBar")

@onready var character_sprite = $Controller/Sprite

# Dialogue interaction variables
var dialogue_initiator_collider = null
@onready var dialogue_ui = preload("res://Player/UI/DialogueUI.tscn").instantiate()
@onready var dialogue_button = dialogue_ui.get_node("DialogueButton")

# Respawn button
@onready var respawn_button = $Controller/RespawnButton

# Runs when the node is added to the scene, before any other operations complete
func _ready():
	# Set player initial health value
	health_bar.value = health
	
	# Adds the playerUI to the scene tree, displays independently of camera zoom--fixed to viewport
	add_child(player_ui)
	
	# Adds the dialogueUI to the scene tree for later use
	add_child(dialogue_ui)

func _process(delta):
	
	# Set health bar, monitor player health and perform functions on it.
	health_bar.value = health
	if health <=0:
		player_controller.can_move = false
		respawn_button.visible = true
	
	# Check if player presses "e" to advance, randomize, select, or close dialogue
	if Input.is_action_just_pressed("ui_e"):
		if dialogue_initiator_collider:
			if dialogue_initiator_collider.is_in_group("HelperBot"):
				dialogue_button.show_random_dialogue(dialogue_initiator_collider.dialogue_sequence)
		else:
			dialogue_button.close_dialogue()
			dialogue_button.reset_dialogue_timer()
	
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

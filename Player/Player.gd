extends Node2D

# Player stats and variables
@onready var player_controller = $Controller
var health = 100
@onready var character_sprite = $Controller/Sprite

# Preload and instantiate the PlayerUI scene and health_bar/stamina_bar to access and modify their values
@onready var player_ui = preload("res://Player/UI/Player/PlayerUI.tscn").instantiate()
@onready var health_bar = player_ui.get_node("MarginContainer/VBoxContainer/HealthBar")
@onready var stamina_bar = player_ui.get_node("MarginContainer/VBoxContainer/StaminaBar")

# Inventory UI
@onready var hot_bar = preload("res://Player/UI/Inventory/Hotbar/Hotbar.tscn").instantiate()
@onready var full_inventory = preload("res://Player/UI/Inventory/FullInventory/FullInventory.tscn").instantiate()

# Preload and instantiate the DialogueUI scene and variables to access and modify their values
var dialogue_initiator_collider = null
@onready var dialogue_ui = preload("res://Player/UI/Dialogue/DialogueUI.tscn").instantiate()

# Preload and instantiate the Respawn UI and button
@onready var respawn_ui = preload("res://Player/UI/Respawn/RespawnUI.tscn").instantiate()
# @onready var respawn_button = respawn_ui.get_node("RespawnButton")

# Runs when the node is added to the scene, before any other operations complete
func _ready():
	# Set player initial health value
	health_bar.value = health
	
	# Add all instantiated UIs to player view, independent of camera zoom.
	add_child(player_ui)
	add_child(dialogue_ui)
	add_child(respawn_ui)
	add_child(hot_bar)
	# Set inventory screen to be hidden before being added to the scene, as it should only be open when the player calls it.
	full_inventory.visible = false
	add_child(full_inventory)

func _process(delta):
	# Set health bar, monitor player health and perform functions on it.
	health_bar.value = health
	if health <=0:
		hot_bar.visible = false
		player_controller.can_move = false
		respawn_ui.visible = true
		var testanim:AnimationPlayer = respawn_ui.get_node("DeathLabel/DeathLabelScaleAnimation")
		testanim.play("respawn_text_animation")
		
	
	# Opens the players inventory.
	if Input.is_action_just_pressed("i"):
		full_inventory.visible = not full_inventory.visible

	# Check if player presses "e" to advance, randomize, select, or close dialogue
	if Input.is_action_just_pressed("e"):
		if dialogue_initiator_collider:
			if dialogue_initiator_collider.is_in_group("HelperBot"):
				dialogue_ui.show_random_dialogue(dialogue_initiator_collider.dialogue_sequence)
		else:
			dialogue_ui.close_dialogue()
			dialogue_ui.reset_dialogue_timer()
			
			
	# Kill button
	if Input.is_action_just_pressed("k"):
		health = 0
	
	# Exit game button
	if Input.is_action_just_pressed("q"):
		get_tree().quit()
		
	# Change the window mode of the game between max/windowed. Sets viewport sizes in code to not affect the editor
	if Input.is_action_just_pressed("f"):
		if get_window().mode == Window.MODE_MAXIMIZED:
			get_window().mode = Window.MODE_WINDOWED
			get_window().size = Vector2i(1200, 800)
			get_window().move_to_center()
		else:
			get_window().mode = Window.MODE_MAXIMIZED
	
# Check if player enters dialog initiator, if so, show/set dialog and reset previous timer (if running)
func _on_dialog_collision_tracker_body_entered(body):
	dialogue_initiator_collider = body
	if dialogue_initiator_collider.is_in_group("HelperBot"):
		dialogue_ui.reset_dialogue_timer()
		dialogue_ui.show_random_dialogue(dialogue_initiator_collider.dialogue_sequence)

# Check if the player leaves a dialog initiator, if so, start dialog closing timer
func _on_dialog_collision_tracker_body_exited(body):
	if dialogue_initiator_collider:
		if dialogue_initiator_collider.is_in_group("HelperBot"):
			dialogue_ui.reset_dialogue_timer(true)
		dialogue_initiator_collider = null

extends CanvasLayer

# Set how long the dialog stays open when the character leaves a dialog initiator
var dialogue_timer = 0
var timer_running = false

var dialogue_disappear_time = 2 # in seconds

@onready var dialogue_button = $DialogueButton

# Hide the dialog box before initialization (allows it to still be viewed while editing)
func _init():
	visible = false
	
# Tracks the timer for when to close the dialog if the player has been gone for too long from an initiator
func _process(delta):
	if timer_running:
		if dialogue_timer > 0:
			dialogue_timer -= delta
		else:
			reset_dialogue_timer()
			visible = false

# When pressed, reset the dialogue timer and close the dialogue
func _on_pressed():
	reset_dialogue_timer()
	visible = false

# Show a specified dialogue string to the player through the dialogue system
func show_dialogue(dialogue):
	dialogue_button.text = dialogue
	visible = true
	
# Show a specified random dialogue from a string array to the player through the dialogue system
func show_random_dialogue(dialogue_list):
	dialogue_button.text = dialogue_list[randi_range(0, dialogue_list.size() - 1)]
	visible = true
	
# Close the currently open dialogue.
func close_dialogue():
	visible = false
	
# Start the dialogue timer, currently used if the player leaves the dialogue initiator
func start_dialogue_timer():
	timer_running = true
	
# Stop the dialogue timer from running, for special instance where it may need paused to last longer due to an event
func stop_dialogue_timer():
	timer_running = false
	
# Reset the dialogue timer back to standard settings, choose to re-run the timer or stop it.
func reset_dialogue_timer(start_timer: bool = false):
	timer_running = start_timer
	dialogue_timer = dialogue_disappear_time

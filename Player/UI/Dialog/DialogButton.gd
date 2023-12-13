extends Button

# Set how long the dialog stays open when the character leaves a dialog initiator
var dialog_timer = 0
var timer_running = false

# Hide the dialog box before initialization (allows it to still be viewed while editing)
func _init():
	visible = false
	
# Tracks the timer for when to close the dialog if the player has been gone for too long from an initiator
func _process(delta):
	if timer_running:
		if dialog_timer > 0:
			dialog_timer -= delta
		else:
			reset_timer()
			visible = false

# When pressed, hide the button dialog and reset the timer
func _on_pressed():
	reset_timer()
	visible = false
	
# External function to reset the timer easily from anywhere
func reset_timer():
	timer_running = false
	dialog_timer = GV.dialog_timer

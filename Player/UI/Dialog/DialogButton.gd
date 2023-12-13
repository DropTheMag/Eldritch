extends Button

# Set how long the dialog stays open when the character leaves a dialog initiator
var dialog_timer = 0
var left_dialog_initiator = false

# Hide the dialog box before initialization (allows it to still be viewed while editing)
func _init():
	visible = false
	
# Tracks the timer for when to close the dialog if the player has been gone for too long from an initiator
func _process(delta):
	if left_dialog_initiator:
		if dialog_timer > 0:
			dialog_timer -= delta
		else:
			visible = false
			#GV.dialog_open = false
			left_dialog_initiator = false

# When pressed, hide the button dialog and let the GV know it's closed
func _on_pressed():
	visible = false
	#GV.dialog_open = false

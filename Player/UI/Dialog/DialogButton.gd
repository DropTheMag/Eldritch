extends Button

# Hide the dialog box before initialization (allows it to still be viewed while editing)
func _init():
	visible = false

# When pressed, hide the button dialog and let the GV know it's closed
func _on_pressed():
	visible = false
	GV.dialog_open = false

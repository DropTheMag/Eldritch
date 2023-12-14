extends Control

# Goes back to main menu/ game eventually
func _on_back_button_pressed():
	var main_menu = "res://Menus/MainMenu/MainMenu.tscn"
	get_tree().change_scene_to_file(main_menu)

extends Control

# Start game
func _on_new_game_button_pressed():
	var first_level = "res://Levels/Controller/Controller.tscn"
	get_tree().change_scene_to_file(first_level)

# Opens Settings Menu
func _on_settings_button_pressed():
	var settings_menu = "res://Menus/SettingsMenu/SettingsMenu.tscn"
	get_tree().change_scene_to_file(settings_menu)
	
	#Quits Game
func _on_quit_game_button_pressed():
	get_tree().quit()

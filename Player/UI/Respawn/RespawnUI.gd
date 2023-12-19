extends CanvasLayer

@onready var player = get_parent()
@onready var player_controller = player.get_node("Controller")

# Hide UI elements on initialization. Leaves visible in editor for editing, hides in-game until needed
func _init():
	visible = false

func _on_respawn_button_pressed():
	# Respawn the player at location when pressed, reset health, reenable movement
	visible = false
	player.health = 100
	player_controller.position = Vector2(0, 0)
	player_controller.can_move = true
	player.get_node("HotBar").visible = true

extends Button

@onready var player = get_parent().get_parent()
@onready var player_controller = get_parent()

func _on_pressed():
	# Respawn the player at location., reset health, reenable movement
	visible = false
	player.health = 100
	player_controller.position = Vector2(0, 0)
	player_controller.can_move = true

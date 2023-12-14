extends CharacterBody2D

var speed = 100
var can_move = true

@onready var player_sprite = $Sprite

func _physics_process(delta):
	
	# Disable player movement if required for specific events (death, dialogue, cutscene, etc.)
	if can_move:
		velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * speed

		# Change the sprite's direction when going left or right
		if velocity.x < 0:
			player_sprite.scale.x = abs(player_sprite.scale.x)
		elif velocity.x > 0:
			player_sprite.scale.x = -abs(player_sprite.scale.x)

		move_and_slide()

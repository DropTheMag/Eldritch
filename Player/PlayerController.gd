extends CharacterBody2D

var default_speed = 100
var sprint_factor = 1.5
var can_move = true

@onready var player_sprite = $Sprite

func _physics_process(delta):
	
	var speed = default_speed
	
	# Disable player movement if required for specific events (death, dialogue, cutscene, etc.)
	if can_move:
		if Input.is_action_pressed("shift"):
			speed = default_speed * sprint_factor
		else:
			speed = default_speed
		velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * speed

		# Change the sprite's direction when going left or right
		if velocity.x < 0:
			player_sprite.scale.x = abs(player_sprite.scale.x)
		elif velocity.x > 0:
			player_sprite.scale.x = -abs(player_sprite.scale.x)

		move_and_slide()

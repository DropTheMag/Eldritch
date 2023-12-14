extends CharacterBody2D

var default_speed = 100
var sprint_factor = 1.5
var can_move = true
var can_sprint = true

var max_stamina = 100
var current_stamina = max_stamina
var stamina_depletion_rate = 0.5
var stamina_regeneration_rate = 0.25
var regen_delay = 2.5  # in seconds
var sprint_stopped_time = 0.0

@onready var player_sprite = $Sprite

func _physics_process(delta):
	var speed = default_speed

	# Disable player movement if required for specific events (death, dialogue, cutscene, etc.)
	if can_move:
		# Player sprint controller
		if can_sprint and Input.is_action_pressed("shift"):
			if current_stamina > 0:
				current_stamina -= stamina_depletion_rate
				speed = default_speed * sprint_factor
				sprint_stopped_time = 0.0
			else:
				speed = default_speed
		else:
			sprint_stopped_time += delta

			if sprint_stopped_time >= regen_delay:
				current_stamina += stamina_regeneration_rate
				current_stamina = clamp(current_stamina, 0, max_stamina)
				speed = default_speed

		# Player base movement controller
		velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * speed

		# Change the sprite's direction when going left or right
		if velocity.x < 0:
			player_sprite.scale.x = abs(player_sprite.scale.x)
		elif velocity.x > 0:
			player_sprite.scale.x = -abs(player_sprite.scale.x)

		get_parent().stamina_bar.value = current_stamina
		move_and_slide()
		print(speed)

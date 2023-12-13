extends Node2D

# Set the time it takes to grow this farm object to the next growth level (in seconds)
var grow_time = randi_range(1, 5)

func _process(delta):
	# Runs the timer tracking the time between each growth level.
	if grow_time > 0:
		grow_time -= delta
	# If the timer ends, advance to the next frame of the sprite. If at max frames, reset for now for testing.
	else:
		var sprite:AnimatedSprite2D = $AnimatedSprite2D
		if sprite.frame < sprite.sprite_frames.get_frame_count("default") - 1:
			sprite.frame = sprite.frame + 1
		else:
			sprite.frame = 0
		grow_time = randi_range(1, 5)

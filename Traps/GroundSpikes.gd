extends Area2D

var time_between_hits = 0.5
var player_in_spikes = false
var hit_at_start = true
var player:CharacterBody2D = null

func _process(delta):
	if player_in_spikes:
		if not hit_at_start:
			player.get_parent().health -= 20
			hit_at_start = true
		if time_between_hits > 0:
			time_between_hits -= delta
		else:
			if player.is_in_group("Player"):
				time_between_hits = 0.5
				player.get_parent().health -=20
			
func _on_body_entered(body):
	player = body
	hit_at_start = false
	player_in_spikes = true

func _on_body_exited(body):
	player = null
	hit_at_start = true
	player_in_spikes = false

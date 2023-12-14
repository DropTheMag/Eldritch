extends Area2D

var time_between_hits = 0.5
var player_in_spikes = false
var player:CharacterBody2D = null

func _process(delta):
	if player_in_spikes:
		if time_between_hits > 0:
			time_between_hits -= delta
		else:
			if player.is_in_group("Player"):
				time_between_hits = 0.5
				player.HEALTH -=20
			
func _on_body_entered(body):
	player = body
	player_in_spikes = true

func _on_body_exited(body):
	player = null
	player_in_spikes = false

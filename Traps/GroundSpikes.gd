extends Area2D



func _on_body_entered(body):
	var player:CharacterBody2D = body
	if player.is_in_group("Player"):
		GV.health -=20
		player.get_child(2).get_child(0).value = GV.health
		

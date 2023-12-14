extends Area2D



func _on_body_entered(body):
	var player:CharacterBody2D = body
	if player.is_in_group("Player"):
		GV.health -=20
		player.get_node("PlayerUI/HealthBar").value = GV.health
		

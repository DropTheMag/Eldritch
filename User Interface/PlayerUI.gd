extends Node2D

@onready var health: TextureProgressBar = $MarginContainer/HealthBar
 
func update_health_bar():
	var health_bar:ProgressBar = get_node("HealthBar")
	health_bar.value = randi_range(0, 100)

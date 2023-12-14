extends Node2D

#@onready var health: TextureProgressBar = $MarginContainer/HealthBar
 
func update_health_bar():
	var HealthBar:TextureProgressBar = $HealthBar
	var StaminaBar:TextureProgressBar = $StaminaBar
	HealthBar.value = randi_range(0, 100)
	StaminaBar.value = randi_range(0, 100)

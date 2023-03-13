extends Node


var house_health = 10

@export var house : Node2D

func on_enemy_entered(area):
	if (area.is_in_group("enemy")):
		house_health -= area.damage
		area.queue_free()

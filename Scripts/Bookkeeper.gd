extends Node


@export var house: Node2D
@export var UI : CanvasLayer

func on_enemy_entered(area):
	if (area.is_in_group("enemy")):
		UI.heath_dec(area.damage)
		area.queue_free()

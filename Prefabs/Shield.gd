extends Area2D

const Bullet = preload("res://Scripts/Bullet.gd")

func on_area_entered(area):
	if area.is_in_group("bullet"):
		var bullet = area as Bullet
		bullet.direction.x = -bullet.direction.x
		bullet.global_transform.x.x = -bullet.global_transform.x.x
		bullet.global_transform.y.x = -bullet.global_transform.y.x
		$ReflectASP.play(0.2)

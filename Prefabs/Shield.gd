extends Area2D

const Bullet = preload("res://Scripts/Bullet.gd")

func on_area_entered(area):
	if area.is_in_group("bullet"):
		var bullet = area as Bullet
		var particle = bullet.get_node("CPUParticles2D")
		var particle_dup = particle.duplicate(DUPLICATE_USE_INSTANTIATION)
		var part_pos = particle.global_position
		add_child(particle_dup)
		particle_dup.global_position = part_pos
		particle_dup.restart()
		bullet.direction.x = -bullet.direction.x
		bullet.global_transform.x.x = -bullet.global_transform.x.x
		bullet.global_transform.y.x = -bullet.global_transform.y.x
		$ReflectASP.play(0.2)
		await get_tree().create_timer(0.2).timeout
		particle_dup.queue_free()

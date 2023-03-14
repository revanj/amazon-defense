extends Area2D

func on_body_entered(body):
	if body.is_in_group("player"):
		body.get_hurt()


func on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.frame == 6:
		queue_free()

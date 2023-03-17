extends Area2D

func _ready():
	$AudioStreamPlayer2D.play()

func on_body_entered(body):
	if body.is_in_group("player"):
		body.get_hurt()


func on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.frame == 4:
		$CollisionShape2D.queue_free()
		$AnimatedSprite2D.queue_free()
		await $AudioStreamPlayer2D.finished
		queue_free()

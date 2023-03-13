extends Area2D



func on_area_entered(area):
	area.queue_free()


func on_body_entered(body):
	body.queue_free()

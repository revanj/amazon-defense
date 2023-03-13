extends Area2D

var direction = Vector2.ZERO
var speed = 1000
var damage = 1

func _ready():
	set_as_top_level(true)

func _physics_process(delta):
	global_position += direction * speed * delta


func on_area_entered(area):
	if area.has_method("hurt"):
		area.hurt(damage)
		queue_free()

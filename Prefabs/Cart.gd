extends AnimatableBody2D

# group enemy
@export var damage = 1
var health = 2

var move_speed = 150
@onready var starting_height = global_position.y

func _physics_process(delta):
	global_position.x -= delta * move_speed
	
func hurt(bullet_damage):
	health -= bullet_damage
	if health <= 0:
		die()
		
func die():
	queue_free()


func on_top_body_entered(body):
	if body.is_in_group("player"):
		body.velocity.y = -500
		die()


func on_hurtbox_body_entered(body):
	if body.is_in_group("player"):
		body.get_hurt()
		die()

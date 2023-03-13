extends Area2D

# group enemy
@export var damage = 1
var health = 2

var move_speed = 200
@onready var starting_height = global_position.y

func _physics_process(delta):
	global_position.x -= delta * move_speed
	global_position.y = starting_height + sin(
		Time.get_ticks_msec() * 0.001 * 4
	) * 50
	
func hurt(bullet_damage):
	health -= bullet_damage
	if health <= 0:
		die()
		
func die():
	queue_free()

	

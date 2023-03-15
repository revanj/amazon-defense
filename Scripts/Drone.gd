extends Area2D
class_name Drone
# group enemy
@export var damage = 1
var health = 2

var moving = true

var move_speed = 200
@onready var starting_height = global_position.y

@onready var shot_death_anim = $ShotDeathAnim
@onready var house_death_anim = $HouseDeathAnim

func _physics_process(delta):
	if !moving:
		return
	global_position.x -= delta * move_speed
	global_position.y = starting_height + sin(
		Time.get_ticks_msec() * 0.001 * 4
	) * 50
	
func hurt(bullet_damage):
	health -= bullet_damage
	if health <= 0:
		die()
		
func die():
	moving = false
	shot_death_anim.modulate.a = 1.0
	shot_death_anim.play("default")
	await shot_death_anim.animation_finished
	queue_free()

func collide():
	moving = false
	house_death_anim.modulate.a = 1.0
	house_death_anim.play("default")
	await house_death_anim.animation_finished
	queue_free()

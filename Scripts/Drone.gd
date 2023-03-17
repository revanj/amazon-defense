extends Area2D
class_name Drone
# group enemy
@export var damage = 1
var health = 2

var moving = true

var move_speed = 200

var phase = 0
var ang_freq = 0.001 * 4
var amp = 50

@onready var starting_height = global_position.y

@onready var shot_death_anim = $ShotDeathAnim
@onready var house_death_anim = $HouseDeathAnim

func _physics_process(delta):
	if !moving:
		return
	global_position.x -= delta * move_speed
	global_position.y = starting_height + sin(
		Time.get_ticks_msec() * ang_freq
	) * amp
	
func hurt(bullet_damage):
	if !moving:
		return
	$HurtSoundASP.play()
	health -= bullet_damage
	if health <= 0 && moving:
		die()
		
func die():
	if moving == false:
		return
	$DeathSoundASP.play()
	ScoreKeeper.score += 1
	moving = false
	shot_death_anim.modulate.a = 1.0
	shot_death_anim.play("default")
	while true:
		if shot_death_anim.frame == 2:
			$AnimatedSprite2D.visible = false
			$CollisionShape2D.visible = false
			$CollisionShape2D2.visible = false
			break
		else:
			await shot_death_anim.frame_changed
	await shot_death_anim.animation_finished
	shot_death_anim.visible = false
	await $DeathSoundASP.finished
	queue_free()

func collide():
	if moving == false:
		return
	moving = false
	house_death_anim.modulate.a = 1.0
	house_death_anim.play("default")
	while true:
		if house_death_anim.frame == 2:
			$AnimatedSprite2D.visible = false
			$CollisionShape2D.visible = false
			$CollisionShape2D2.visible = false
			break
		else:
			await house_death_anim.frame_changed
	await house_death_anim.animation_finished
	queue_free()

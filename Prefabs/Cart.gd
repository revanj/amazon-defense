extends Node2D

# group enemy
@export var damage = 1
var health = 2

var move_speed = 150.0
@onready var starting_height = global_position.y

var moving = true

@onready var shot_death_anim = $ShotDeathAnim
@onready var house_death_anim = $HouseDeathAnim


func _physics_process(delta):
	if !moving:
		return
	global_position.x -= delta * move_speed
	
func hurt(bullet_damage):
	if !moving:
		return
	$MetalShotASP.play()
	health -= bullet_damage
	if health <= 0:
		die()

func die():
	if !moving:
		return
	ScoreKeeper.score += 1
	$DeathSoundASP.play()
	$Area2D.queue_free()
	$Top.queue_free()
	$CollisionShape2D.queue_free()
	moving = false
	shot_death_anim.modulate.a = 1.0
	shot_death_anim.play("default")
	while true:
		if shot_death_anim.frame == 2:
			$AnimatedSprite2D.visible = false
			break
		else:
			await shot_death_anim.frame_changed
	await shot_death_anim.animation_finished
	shot_death_anim.visible = false
	await $DeathSoundASP.finished
	queue_free()

func collide():
	if !moving:
		return
	$CollisionSoundASP.play()
	moving = false
	house_death_anim.modulate.a = 1.0
	house_death_anim.play("default")
	while true:
		if house_death_anim.frame == 1:
			$AnimatedSprite2D.visible = false
			$Area2D.visible = false
			$Top.visible = false
			break
		else:
			await house_death_anim.frame_changed
	await house_death_anim.animation_finished
	house_death_anim.visible = false
	await $CollisionSoundASP.finished
	queue_free()

func on_top_body_entered(body):
	if body.is_in_group("player"):
		body.velocity.y = -500
		die()


func on_hurtbox_body_entered(body):
	if body.is_in_group("player"):
		body.get_hurt()
		collide()

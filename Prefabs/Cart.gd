extends AnimatableBody2D

# group enemy
@export var damage = 1
var health = 2

var move_speed = 150
@onready var starting_height = global_position.y

var moving = true

@onready var shot_death_anim = $ShotDeathAnim
@onready var house_death_anim = $HouseDeathAnim

func _physics_process(delta):
	if !moving:
		return
	global_position.x -= delta * move_speed
	
func hurt(bullet_damage):
	health -= bullet_damage
	if health <= 0:
		die()
		
func die():
	if !moving:
		return
	moving = false
	shot_death_anim.modulate.a = 1.0
	shot_death_anim.play("default")
	while true:
		if shot_death_anim.frame == 2:
			$AnimatedSprite2D.visible = false
			$Area2D.visible = false
			$Top.visible = false
			break
		else:
			await shot_death_anim.frame_changed
	await shot_death_anim.animation_finished
	queue_free()

func collide():
	if !moving:
		return
	ScoreKeeper.score += 1
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
	queue_free()

func on_top_body_entered(body):
	if body.is_in_group("player"):
		body.velocity.y = -500
		die()


func on_hurtbox_body_entered(body):
	if body.is_in_group("player"):
		body.get_hurt()
		die()

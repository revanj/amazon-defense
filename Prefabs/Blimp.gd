extends Area2D

# group enemy
@export var damage = 2
var health = 4

var moving = true

@onready var anchor1 = $Anchor1
@onready var anchor2 = $Anchor2

@onready var mainsprite = $AnimatedSprite2D
@onready var deathanim = $DeathAnim

@onready var collideanim1 = $CollisionAnim
@onready var collidenanim2 = $CollisionAnim2

var projectile = preload("res://Prefabs/BlimpProjectile.tscn")

var move_speed = 50
@onready var starting_height = global_position.y

func _ready():
	while(true):
		if !moving:
			break
		await get_tree().create_timer(1.5).timeout
		for anchor in [anchor1, anchor2]:
			var inst = projectile.instantiate()
			add_child(inst)
			inst.set_as_top_level(true)
			inst.global_position = anchor.global_position
			inst.activate()

func _physics_process(delta):
	if !moving:
		return
	global_position.x -= delta * move_speed
	
func hurt(bullet_damage):
	health -= bullet_damage
	if health <= 0:
		die()
		
func collide():
	if moving == false:
		return
	moving = false
	collideanim1.modulate.a = 1.0
	collideanim1.play("default")
	while true:
		if collideanim1.frame == 2:
			collidenanim2.modulate.a = 1.0
			collidenanim2.play("default")
			$AnimatedSprite2D.visible = false
			$CollisionShape2D.visible = false
			break
		else:
			await collideanim1.frame_changed
	await collidenanim2.animation_finished
	queue_free()
		
func die():
	if !moving:
		return
	ScoreKeeper.score += 1
	moving = false
	mainsprite.visible = false
	$CollisionShape2D.visible = false
	deathanim.modulate.a = 1.0
	deathanim.play("default")
	await deathanim.animation_finished
	queue_free()

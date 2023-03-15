extends Area2D

# group enemy
@export var damage = 2
var health = 4

@onready var anchor1 = $Anchor1
@onready var anchor2 = $Anchor2

var projectile = preload("res://Prefabs/BlimpProjectile.tscn")

var move_speed = 50
@onready var starting_height = global_position.y

func _ready():
	while(true):
		await get_tree().create_timer(1.5).timeout
		for anchor in [anchor1, anchor2]:
			var inst = projectile.instantiate()
			add_child(inst)
			inst.set_as_top_level(true)
			inst.global_position = anchor.global_position
			inst.activate()

func _physics_process(delta):
	global_position.x -= delta * move_speed
	
func hurt(bullet_damage):
	health -= bullet_damage
	if health <= 0:
		die()
		
func die():
	queue_free()

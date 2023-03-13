extends CharacterBody2D

@export var walk_speed = 500
@export var gravity = 25
@export var max_fall_speed = 500
@export var jump_force = 500

@export var gun_anchor: Node2D

var bullet = preload("res://Prefabs/Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	gun_anchor.look_at(get_global_mouse_position())
	if (Input.is_action_just_pressed("fire")):
		var bullet_inst = bullet.instantiate()
		bullet_inst.global_position = gun_anchor.global_position
		bullet_inst.direction = gun_anchor.global_transform.x
		add_child(bullet_inst)

	
func _physics_process(_delta):
	var input_dir = 0
	if Input.is_action_pressed("left"):
		input_dir -= 1
	if Input.is_action_pressed("right"):
		input_dir += 1
	
	if is_on_floor() && Input.is_action_just_pressed("jump"):
		velocity.y -= jump_force
	
	if is_on_floor() && velocity.y > 0:
		velocity.y = 0
		
	velocity.x =  input_dir * walk_speed
	
	velocity.y += gravity
	if velocity.y > max_fall_speed:
		velocity.y = max_fall_speed
	move_and_slide()
	

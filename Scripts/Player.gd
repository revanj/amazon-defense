extends CharacterBody2D

@export var walk_speed = 500
@export var gravity = 25
@export var max_fall_speed = 500
@export var jump_force = 500

@export var gun_anchor: Node2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var arms = $GunAnchor/PlayerArms
@onready var gun = $GunAnchor/PlayerArms/WeaponRifle
@onready var anchor_start_pos = $GunAnchor.position
@onready var gun_tip = $GunAnchor/PlayerArms/WeaponRifle/GunTip

var bullet = preload("res://Prefabs/Bullet.tscn")

var is_hurting = false
var can_be_hurt = true
var hurt_stun = false

var can_shoot = true

func shoot_maintainer():
	can_shoot = false
	await get_tree().create_timer(0.15).timeout
	can_shoot = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# the player is only allowed to fire when they are not hurt
	# i.e. when the player can be hurt
	if (Input.is_action_just_pressed("fire") && !hurt_stun && can_shoot):
		shoot_maintainer()
		$GunshotASP2D.play_poly()
		var bullet_inst = bullet.instantiate()
		bullet_inst.global_position = gun_anchor.global_position
		bullet_inst.global_rotation = gun_anchor.global_rotation
		bullet_inst.global_position += gun_anchor.global_transform.x * 45
		bullet_inst.direction = gun_anchor.global_transform.x
		add_child(bullet_inst)

	
func _physics_process(_delta):
	var input_dir = 0
	if Input.is_action_pressed("left"):
		input_dir -= 1
	if Input.is_action_pressed("right"):
		input_dir += 1
	
	if hurt_stun:
		input_dir = 0
		
	if hurt_stun:
		animated_sprite.play("hurt")
	else:
		if !is_on_floor():
			animated_sprite.play("jump")
		else:
			if input_dir == 0:
				animated_sprite.play("default")
			else:
				animated_sprite.play("run")
		
	var facing_dir = sign(get_global_mouse_position().x - global_position.x) 
	
	if facing_dir == input_dir:
		animated_sprite.speed_scale = 1
	else:
		animated_sprite.speed_scale = -1
	
	if !hurt_stun:
		animated_sprite.flip_h = !(facing_dir == 1)
		gun_anchor.position = Vector2(
			anchor_start_pos.x * facing_dir,
			anchor_start_pos.y)
		arms.scale.y = facing_dir * 1.5
		gun_anchor.look_at(get_global_mouse_position())
		if is_on_floor() && Input.is_action_just_pressed("jump"):
			velocity.y -= jump_force
	
	if is_on_floor() && velocity.y > 0:
		velocity.y = 0
	
	if !hurt_stun:
		velocity.x =  input_dir * walk_speed
	else:
		velocity.x = 0
	
	velocity.y += gravity
	if velocity.y > max_fall_speed:
		velocity.y = max_fall_speed
	
	if hurt_stun:
		velocity.y = 0
	
	move_and_slide()
	
func get_hurt():
	if !can_be_hurt:
		return
	$HurtSound.play()
	can_be_hurt = false
	hurt_stun = true

	await get_tree().create_timer(0.6).timeout
	
	hurt_stun = false
	
	var tween = get_tree().create_tween()
	var gap_time = 0.08
	var loop_count = 5
	for i in range(loop_count):
		tween.tween_property(self, "modulate", Color.TRANSPARENT, gap_time)
		tween.tween_property(self, "modulate", Color.WHITE, gap_time)
	
	tween.tween_callback(func(): can_be_hurt = true)

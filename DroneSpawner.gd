extends Node

@export var timer: Timer
@onready var drone_spawn_point: Node2D = $DroneSpawnPoint
@onready var cart_spawn_point: Node2D = $CartSpawnPoint
@onready var blimp_spawn_point: Node2D = $BlimpSpawnPoint

var drone = preload("res://Prefabs/Drone.tscn")
var cart = preload("res://Prefabs/Cart.tscn")
var drone_drop = preload("res://Prefabs/DroneDrop.tscn")
var drone_shield_front = preload("res://Prefabs/ForwardShieldededDrone.tscn")
var blimp = preload("res://Prefabs/Blimp.tscn")

var time_started
var time_elapsed


func _ready():
	time_started = Time.get_ticks_msec() / 1000.0
	time_elapsed = 0
	drone_spawn_coro()
	cart_spawn_coro()
	blimp_spawn_coro()
	

func _physics_process(delta):
	time_elapsed = Time.get_ticks_msec() / 1000.0 - time_started

@onready var drone_prefabs = [drone, drone_drop, drone_shield_front]
func drone_spawn_coro():
	var base_spawntime = 3
	# wait out system init
	await get_tree().create_timer(1).timeout
	while true:
		send_drone()
		var time_to_wait = base_spawntime / (1 + 1.0 / 150.0 * time_elapsed)
		var p = 1 - 2 / ( 1 + exp(-time_elapsed/150))
		for x in range(2):
			var test = randf_range(0,1)
			if test < p:
				var interval_time = time_to_wait / 4 * randf_range(0.2, 1.2)
				await get_tree().create_timer(
					interval_time
				).timeout
				send_drone()
				time_to_wait -= interval_time
		await get_tree().create_timer(time_to_wait).timeout
		
func send_drone():
	var top = 0
	var bottom = 285
	var drone_top_height = 11
	var drone_bottom_height = 42
	var max_amp =(
			(bottom - drone_bottom_height) - (top + drone_top_height)
		) / 2 * 0.8 # taking up the entire lane seems excessvie
	var min_amp = 20
	var min_drone_speed = 150
	var max_drone_speed = 230
	var amp = randf_range(min_amp, max_amp)
	var min_height = top + drone_top_height + amp
	var max_height = bottom - drone_bottom_height - amp
	var height = randf_range(min_height, max_height)
	var speed = (randf_range(min_drone_speed, max_drone_speed)
			* log(exp(1) + time_elapsed / 500)
	)
	var drone = spawn_drone(
		drone_prefabs[randi_range(0,len(drone_prefabs)-1)],
		drone_spawn_point.global_position.x,
		height
		)
	drone.global_position.x = drone_spawn_point.global_position.x
	drone.amp = amp
	drone.starting_height = height
	drone.move_speed = speed

func cart_spawn_coro():
	await get_tree().create_timer(3).timeout
	while true:
		var base_spawn_time = 3
		send_cart()
		var time_to_wait = base_spawn_time / (1 + 1 / 100 * time_elapsed) * randf_range(0.9,1.1)
		await get_tree().create_timer(time_to_wait).timeout

func send_cart():
	var min_cart_speed = 130
	var max_cart_speed = 160
	var speed = (randf_range(min_cart_speed, max_cart_speed)
			* log(exp(1) + time_elapsed / 600)
			)
	var inst = spawn_drone(cart, 
		cart_spawn_point.global_position.x, 
		cart_spawn_point.global_position.y)
	inst.global_position = cart_spawn_point.global_position
	inst.move_speed = speed
	inst.moving = true
	
func send_blimp():
	var min_blimp_speed = 40
	var max_blimp_speed = 60
	var speed = (randf_range(min_blimp_speed, max_blimp_speed))
	var inst = spawn_drone(blimp, 
		blimp_spawn_point.global_position.x, 
		blimp_spawn_point.global_position.y)
	inst.global_position = blimp_spawn_point.global_position
	inst.move_speed = speed
	inst.moving = true
	
func blimp_spawn_coro():
	await get_tree().create_timer(15).timeout
	while true:
		var base_spawn_time = 20
		send_blimp()
		var time_to_wait = base_spawn_time / (1 + 1 / 100 * time_elapsed) * randf_range(0.9,1.1)
		await get_tree().create_timer(time_to_wait).timeout
		
func spawn_drone(enemy, spawn_x, spawn_y):
	var inst = enemy.instantiate()
	inst.global_position.x = spawn_x
	inst.starting_height = spawn_y
	get_tree().get_current_scene().add_child(inst)
	inst.global_position.x = spawn_x
	
	return inst # return the instance for further processing
	

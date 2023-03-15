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

@onready var prefabs = [drone, cart, drone_drop, drone_shield_front, blimp]
@onready var spawn = [drone_spawn_point, cart_spawn_point, drone_spawn_point, drone_spawn_point, blimp_spawn_point]
func _ready():
	var rng = RandomNumberGenerator.new()
	var last_blimp = false
	while (true):
		await timer.timeout
		var number = rng.randi_range(0,prefabs.size()-1)
		if last_blimp && number == 4:
			last_blimp = false
			continue
		spawn_drone(prefabs[number], spawn[number])
		last_blimp = (number == 4)
		
		
		
func spawn_drone(enemy, spawn_point):
	var inst = enemy.instantiate()
	inst.global_position = spawn_point.global_position
	inst.starting_height = spawn_point.global_position.y
	get_tree().get_current_scene().add_child(inst)
	

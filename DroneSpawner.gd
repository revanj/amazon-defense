extends Node

@export var timer: Timer
@export var drone_spawn_point: Node2D
@export var cart_spawn_point: Node2D

var drone = preload("res://Prefabs/Drone.tscn")
var cart = preload("res://Prefabs/Cart.tscn")
var drone_drop = preload("res://Prefabs/DroneDrop.tscn")

@onready var prefabs = [drone, cart, drone_drop]
@onready var spawn = [drone_spawn_point, cart_spawn_point, drone_spawn_point]
func _ready():
	var rng = RandomNumberGenerator.new()
	while (true):
		await timer.timeout
		var number = rng.randi_range(0,2)
		spawn_drone(prefabs[number], spawn[number])
		
		
		
func spawn_drone(enemy, spawn_point):
	var inst = enemy.instantiate()
	inst.global_position = spawn_point.global_position
	inst.starting_height = spawn_point.global_position.y
	get_tree().root.add_child(inst)
	

extends Node

@export var timer: Timer
@export var spawn_point: Node2D

var drone = preload("res://Prefabs/Drone.tscn")

func _ready():
	while (true):
		await timer.timeout
		spawn_drone()
		
		
		
func spawn_drone():
	var drone_inst = drone.instantiate()
	get_tree().root.add_child(drone_inst)
	drone_inst.global_position = spawn_point.global_position
	drone_inst.starting_height = spawn_point.global_position.y

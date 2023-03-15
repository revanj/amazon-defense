extends Area2D

var activated = false
var fall_speed = 500
var move_speed = 0

var explosion_area = preload("res://Prefabs/DropExplosionArea.tscn")

func activate():
	var previous_transform = global_transform
	var new_parent = get_tree().get_current_scene()
	get_parent().remove_child(self)
	new_parent.call_deferred("add_child", self)
	global_transform = previous_transform
	activated = true

func _physics_process(delta):
	if activated:
		global_position.y += delta * fall_speed
		global_position.x -= delta * move_speed
		
func on_package_body_entered(body):
	if body.is_in_group("floor") || body.is_in_group("player"):
		activated = false
		var explosion_inst = explosion_area.instantiate()
		get_tree().root.call_deferred("add_child", explosion_inst)
		explosion_inst.global_position = global_position
		queue_free()

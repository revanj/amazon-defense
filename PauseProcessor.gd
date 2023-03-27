extends Node

@export var pause_menu: TextureRect


func _input(event):
	if event is InputEventKey and event.is_action_pressed("pause"):
		if pause_menu.visible == false:
			get_tree().paused = true
			pause_menu.show()
		else:
			pause_menu.hide()
			get_tree().paused = false

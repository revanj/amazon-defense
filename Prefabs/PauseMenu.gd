extends TextureRect


func _input(event):
	if event.is_action_pressed("pause"):
		print("here")
		self.hide()
		get_tree().paused = false
		

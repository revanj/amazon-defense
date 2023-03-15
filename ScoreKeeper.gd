extends Node

var score = 0

func cleanup():
	var list_children = get_tree().root.get_children()
	for child in list_children:
		child.queue_free()

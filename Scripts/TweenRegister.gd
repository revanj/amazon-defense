extends Node

var tweens = []


func _process(delta):
	for i in tweens:
		if !i.is_valid():
			tweens.erase(i)

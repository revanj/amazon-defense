extends CanvasLayer

@export var crystal0: Control
@export var crystal1: Control
@export var crystal2: Control
@export var crystal3: Control
@export var crystal4: Control

# no I am not mad
# godot array export is broken for some reason
@onready var crystals = [crystal0, crystal1, crystal2, crystal3, crystal4]

var current_health = 5

func heath_dec(amount):
	current_health -= amount
	if current_health < 0:
		current_health = 0
	for i in range(0, current_health):
		crystals[i].modulate.a = 1
	for i in range(current_health, 5):
		crystals[i].modulate.a = 0
	if current_health == 0:
		end_sequence()

func end_sequence():
	get_tree().call_group("projectile", "queue_free")
	for tween in TweenRegister.tweens:
		if tween.is_valid():
			tween.kill()	
	get_tree().change_scene_to_file("res://EndScene.tscn")

func _process(delta):
	$Label.text = "Drones killed: " + str(ScoreKeeper.score)

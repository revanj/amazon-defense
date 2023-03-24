extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$RichTextLabel.text = "You resisted " + str(ScoreKeeper.score) + " of Bezos' Drones"


func _on_retry_button_pressed():
	ScoreKeeper.score = 0
	get_tree().change_scene_to_file("res://GameScene.tscn")



func _on_main_menu_button_pressed():
	ScoreKeeper.score = 0
	get_tree().change_scene_to_file("res://TitleScene.tscn")

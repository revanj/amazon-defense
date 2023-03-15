extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$RichTextLabel.text = "You resisted " + str(ScoreKeeper.score) + " of Bezos' Drones"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

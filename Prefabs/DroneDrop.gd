extends Drone

func die():
	$AnimatedSprite2D/PackageStandard.activate()
	super()


func _ready():
	$AnimatedSprite2D/PackageStandard.move_speed = self.move_speed

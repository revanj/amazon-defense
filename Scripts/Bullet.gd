extends Area2D

var direction = Vector2.ZERO
var speed = 1000
var damage = 1
var moving = true

func _ready():
	set_as_top_level(true)

func _physics_process(delta):
	if !moving:
		return
	global_position += direction * speed * delta


func on_area_entered(area):
	if area.is_in_group("enemy"):
		moving = false
		area.hurt(damage)
		$CollisionShape2D.queue_free()
		$Sprite2D.visible = false
		$CPUParticles2D.restart()
		await get_tree().create_timer(0.2).timeout
		queue_free()


func _on_body_entered(body):
	if body.is_in_group("enemy"):
		moving = false
		body.hurt(damage)
		$CollisionShape2D.queue_free()
		$Sprite2D.visible = false
		$CPUParticles2D.restart()
		await get_tree().create_timer(0.2).timeout
		queue_free()
	if body.is_in_group("floor"):
		moving = false
		$CollisionShape2D.queue_free()
		$Sprite2D.visible = false
		$CPUParticles2D.restart()
		await get_tree().create_timer(0.2).timeout
		queue_free()
		
		

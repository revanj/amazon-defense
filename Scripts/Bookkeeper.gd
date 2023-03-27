extends Node


@export var house: Node2D
@export var UI : CanvasLayer

var can_be_hurt = true

func on_enemy_entered(area):
	if (area.is_in_group("enemy")):
		UI.heath_dec(area.damage)
		area.collide()
		if !can_be_hurt:
			return
		can_be_hurt = false
		var house = get_node("../House/House2")
		var tween = get_tree().create_tween()
		TweenRegister.tweens.append(tween)
		var target_color = Color(1,0.57,0.57)
		tween.tween_property(house, "modulate", target_color, 0.1)
		tween.tween_property(house, "modulate", Color.WHITE, 0.1)
		tween.tween_property(house, "modulate", target_color, 0.1)
		tween.tween_property(house, "modulate", Color.WHITE, 0.1)
		tween.tween_property(house, "modulate", target_color, 0.1)
		tween.tween_property(house, "modulate", Color.WHITE, 0.1)
		tween.tween_property(house, "modulate", target_color, 0.1)
		tween.tween_property(house, "modulate", Color.WHITE, 0.1)
		tween.tween_callback(func(): can_be_hurt = true)


func on_area_2d_body_entered(body):
	if (body.is_in_group("enemy")):
		
		UI.heath_dec(body.damage)
		body.collide()
		if !can_be_hurt:
			return
		can_be_hurt = false
		var house = get_node("../House/House2")
		var tween = get_tree().create_tween()
		tween.add_to_group("tweens")
		var target_color = Color(1,0.57,0.57)
		tween.tween_property(house, "modulate", target_color, 0.1)
		tween.tween_property(house, "modulate", Color.WHITE, 0.1)
		tween.tween_property(house, "modulate", target_color, 0.1)
		tween.tween_property(house, "modulate", Color.WHITE, 0.1)
		tween.tween_property(house, "modulate", target_color, 0.1)
		tween.tween_property(house, "modulate", Color.WHITE, 0.1)
		tween.tween_property(house, "modulate", target_color, 0.1)
		tween.tween_property(house, "modulate", Color.WHITE, 0.1)
		tween.tween_callback(func(): can_be_hurt = true)

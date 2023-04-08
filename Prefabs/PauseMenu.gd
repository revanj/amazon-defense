extends TextureRect

@onready var effect_bus = AudioServer.get_bus_index("Effect")
@onready var music_bus = AudioServer.get_bus_index("Music")


func _on_effect_slider_value_changed(value):
	AudioServer.set_bus_volume_db(effect_bus, linear_to_db(value))


func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))

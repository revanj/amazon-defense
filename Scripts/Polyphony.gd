	#helper for multiple audio stream playback
extends AudioStreamPlayer2D

func play_poly( from_position=0.0 ):
	if !playing:
		play(from_position)
	else:
		var asp = self.duplicate(DUPLICATE_USE_INSTANTIATION)
		get_parent().add_child(asp)
		asp.stream = stream
		asp.play()
		await asp.finished
		asp.queue_free()

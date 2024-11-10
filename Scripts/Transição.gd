extends CanvasLayer


func change_scene(path, delay = 0.5):
	$efeito.interpolate_property($overlay, "progress", 0.0, 1.0, 2.0, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
	$efeito.start()
	yield($efeito, "tween_completed")
	assert(get_tree().change_scene(path) == OK)

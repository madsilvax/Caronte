extends Label

func _process(delta: float) -> void:
	text = "0" + String(Global.almas)
	if Global.almas >= 10:
		text = String(Global.almas)

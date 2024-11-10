extends Area2D

var almas = 1

func _on_Almas_body_entered(body):
	$anim.play("coleta")
	$almaFX.play()
	Global.almas += almas
	print(Global.almas)

func _on_anim_animation_finished(anim_name):
	if anim_name == "coleta":
		queue_free()

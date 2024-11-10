extends Control

func _on_Iniciar_pressed():
	get_tree().change_scene("res://Cenas/Fase_01.tscn")

func _on_Controles_pressed():
	var TelaControles = load("res://Cenas/TelaControles.tscn").instance()
	get_tree().current_scene.add_child(TelaControles)

func _on_Sair_pressed():
	get_tree().quit

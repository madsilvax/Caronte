extends CanvasLayer

func _on_Tente_Novamente_pressed():
	get_tree().change_scene("res://Cenas/Fase_01.tscn")

func _on_Sair_pressed():
	get_tree().quit
	
func _on_Menu_inicial_pressed():
	get_tree().change_scene("res://Cenas/TelaInicial.tscn")

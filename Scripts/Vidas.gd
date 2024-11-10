extends Control

var life_size = 20

func on_change_life(player_health):
	$vidas.rect_size.x = player_health * life_size

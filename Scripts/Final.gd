extends Area2D

onready var changer = get_parent().get_node("Transição")
export var path: String

func _ready():
	pass


func _on_Final_body_entered(body: Node) -> void:
	if body.name == "Player":
		changer.change_scene(path)

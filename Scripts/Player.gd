extends KinematicBody2D
class_name Player

var velocity = Vector2.ZERO
var move_speed = 1250
var gravity = 2000
var jump_force = -650
var is_grounded

var player_health = 3
var max_health = 3
var hurted = false

var knockback_dir = 1
var knockback_int = 2000

onready var raycasts = $raycasts

signal change_life(player_health)

func _ready() -> void:
# warning-ignore:return_value_discarded
	connect("change_life", get_parent().get_node("HUD/HBoxContainer/Vidas"), "on_change_life")
	emit_signal("change_life", max_health)

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	
	_get_input()
	
	velocity = move_and_slide(velocity)
	
	is_grounded = _check_is_grounded()
	
	_set_animation()
	
	for platforms in get_slide_count():
		var collision = get_slide_collision(platforms)
		if collision.collider.has_method("collide_with"):
			collision.collider.collide_with(collision, self)

func _get_input():
	velocity.x = 0
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
	
	if move_direction !=0:
		$textura.scale.x = move_direction
		knockback_dir = move_direction

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_grounded:
		velocity.y = jump_force
		$jumpFX.play()

func _check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
			
	return false

func _set_animation():
	var anim = "Idle"
	
	if !is_grounded:
		anim = "jump"
	elif velocity.x !=0:
		anim = "run"
	if velocity.y > 0 and !is_grounded:
		anim = "fall"
	if hurted:
		anim = "hit"
	
	if $anim.assigned_animation != anim:
		$anim.play(anim)

func knockback():
	if $direita.is_colliding():
		velocity.x = -knockback_dir * knockback_int
	if $esquerda.is_colliding():
		velocity.x = knockback_dir * knockback_int
	
	velocity = move_and_slide(velocity)

func _on_hurtbox_body_entered(body: Node) -> void:
	player_health -= 1
	hurted = true
	emit_signal("change_life", player_health)
	knockback()
	get_node("hurtbox/colisao").set_deferred("disable", true)
	yield(get_tree().create_timer(0.5), "timeout")
	get_node("hurtbox/colisao").set_deferred("disable", false)
	hurted = false
	gameOver()

func gameOver() -> void:
	if player_health < 1:
		queue_free()
		get_tree().change_scene("res://Cenas/GameOver.tscn")

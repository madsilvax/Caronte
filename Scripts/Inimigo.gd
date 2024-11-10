extends KinematicBody2D

export var speed = 64
export var health = 1
var velocity = Vector2.ZERO
var move_direction = -1
var gravity = 1000
var hitted= false

func _physics_process(delta: float) -> void:
	velocity.x = speed * move_direction
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity)
	
	if move_direction == -1: 
		$textura.flip_h = true
	else:
		$textura.flip_h = false
	
	if $raywall.is_colliding():
		$raywall.scale.x *= -1
		move_direction *= -1



func _on_hitbox_body_entered(body: Node) -> void:
	$hitFX.play()
	hitted = true
	health -= 1
	hitted = false
	yield(get_tree().create_timer(0.2),"timeout")
	if health < 1:
		queue_free()
		get_node("hitbox/colisao").set_deferred("disabled", true)

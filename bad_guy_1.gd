extends CharacterBody2D


# var target = player


const SPEED = 3

func _physics_process(delta):
	var player = get_parent().get_node("Protaginast_guy")
	var target = player
	position += (target.position - position).normalized() * SPEED

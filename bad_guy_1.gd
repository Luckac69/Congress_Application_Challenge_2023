extends CharacterBody2D


# var target = player
@onready var animation = $AnimationPlayer

const SPEED = 3

func _physics_process(delta):
	var player = get_parent().get_node("Protaginast_guy")
	var target = player
	
	animation.play("Walk")
	
	position += (target.position - position).normalized() * SPEED

extends CharacterBody2D

class_name Enemy
# var target = player
@onready var animation = $AnimationPlayer
@onready var target = $"../Protaginast_guy"
var SPEED : float = 250

func _physics_process(delta):
	if target == null: target = get_tree().get_first_node_in_group("Player")
	if target != null:
		animation.play("Walk")
		velocity = position.direction_to(target.position) * SPEED
		move_and_slide()
		#position += (target.position - position).normalized() * SPEED
	# var player = get_parent().get_node("Protaginast_guy")
	# var target = player
	
	print(target)
	


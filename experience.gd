extends CharacterBody2D

@onready var animation = $AnimationPlayer

var speed = 1000
var target: Node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("GlowCycle")
	add_to_group("Experience")

# Called every frame
func _process(delta):
	if target:
		var direction = (target.global_position - global_position).normalized()
		move_and_collide(direction * speed * delta)

func _on_detection_area_area_entered(body):
	if body.get_parent().is_in_group("Player"):
		target = body

# EXP orb disappears when it touches the player
func _on_exp_absorption_area_entered(body):
	if body.get_parent().is_in_group("Player"):
		self.queue_free()

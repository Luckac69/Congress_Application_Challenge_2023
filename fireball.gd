extends CharacterBody2D

@onready var animation = $AnimationPlayer

var speed = 2000
var velocitiy = Vector2(1, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var collisioninfo = move_and_collide(velocity.normalized() * delta * speed)



func _on_fireball_hitbox_area_entered(area):
	pass # Replace with function body.

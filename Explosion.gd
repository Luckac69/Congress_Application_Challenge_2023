extends CharacterBody2D

@onready var animation = $AnimationPlayer
@export var hit_effect : PackedScene

var speed = 1250
var velocitiy = Vector2(1, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("idle")
	add_to_group("Bullet")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var collisioninfo = move_and_collide(velocity.normalized() * delta * speed)

func _on_explosion_initial_hitbox_area_entered(body):
	if body.get_parent().is_in_group("Enemy"):
		$"/root/GlobalScript".camera.shake(1.0, 3)
		var effect_instance : GPUParticles2D = hit_effect.instantiate()
		effect_instance.position = body.get_parent().position
		get_parent().add_child(effect_instance)
		effect_instance.emitting = true
		self.queue_free()

extends CharacterBody2D

@onready var animation = $AnimationPlayer
@export var hit_effect : PackedScene

var speed = 800

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("initial cast")
	add_to_group("Explosion")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
	
	if collision_info:
		_on_explosion_initial_hitbox_area_entered(collision_info.collider)

func _on_explosion_initial_hitbox_area_entered(body):
	if body.get_parent().is_in_group("Enemy"):
		$"/root/GlobalScript".camera.shake(1.0, 3)
		var effect_instance : GPUParticles2D = hit_effect.instantiate()
		effect_instance.position = body.get_parent().position
		get_parent().add_child(effect_instance)
		effect_instance.emitting = true
		
		

		animation.play("explosion contact")
		$KaboomTimer.start()


func _on_timer_timeout():
	self.queue_free()

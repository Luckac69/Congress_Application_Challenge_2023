extends CharacterBody2D

@onready var animation = $AnimationPlayer
@export var hit_effect : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("idle")
	add_to_group("Lightning")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position = get_global_mouse_position()
	rotation = 0
	
	
	var collision_info = move_and_collide(velocity.normalized() * delta )
	
	if collision_info:
		_on_lightning_area_entered(collision_info.collider)




func _on_lightning_area_entered(body):
	if body.get_parent().is_in_group("Enemy"):
		$"/root/GlobalScript".camera.shake(1.0, 3)
		"""
		var effect_instance : GPUParticles2D = hit_effect.instantiate()
		effect_instance.position = body.get_parent().position
		get_parent().add_child(effect_instance)
		effect_instance.emitting = true
		"""
		$ShockTimer.start()





func _on_shock_timer_timeout():
	self.queue_free()

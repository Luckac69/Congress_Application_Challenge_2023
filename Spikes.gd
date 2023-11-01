extends CharacterBody2D

@onready var animation = $AnimationPlayer
@export var hit_effect : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("spikeRise")
	add_to_group("Spikes")

func _on_spikes_hitbox_area_entered(body):
	if body.get_parent().is_in_group("Enemy"):
		$"/root/GlobalScript".camera.shake(1.0, 2)
		var effect_instance : GPUParticles2D = hit_effect.instantiate()
		effect_instance.position = body.get_parent().position
		get_parent().add_child(effect_instance)
		effect_instance.emitting = true
		$RetractTimer.start()

func _on_retract_timer_timeout():
	self.queue_free()

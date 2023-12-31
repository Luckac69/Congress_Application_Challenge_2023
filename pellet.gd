extends CharacterBody2D

@onready var animation = $AnimationPlayer
@export var hit_effect : PackedScene

var speed = 2000

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Enemy")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collisioninfo = move_and_collide(velocity.normalized() * delta * speed)

func _on_pellet_hitbox_area_entered(body):
	if body.get_parent().is_in_group("Player"):
		$"/root/GlobalScript".camera.shake(0.2, 3)
		var effect_instance : GPUParticles2D = hit_effect.instantiate()
		effect_instance.position = body.get_parent().position
		get_parent().add_child(effect_instance)
		effect_instance.emitting = true
		self.queue_free()

extends CharacterBody2D

@onready var animation = $AnimationPlayer

var health = 100
const SPEED = 300.0

func _physics_process(delta):
	var yDirection = Input.get_axis("up","down")
	if yDirection:
		velocity.y = yDirection * SPEED
	else:
		velocity.y = move_toward(velocity.y,0,SPEED)
	
	var xDirection = Input.get_axis("left", "right")
	if xDirection:
		velocity.x = xDirection * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if yDirection or xDirection:
		animation.play("Walk")
	else:
		animation.play("Idle")
	
	move_and_slide()
	
	
func update_health():
	var healthbar = $healthbar
	
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
		

func _on_regin_timer_timeout():
	if health < 100:
		health = health + 5
		if health > 100:
			health = 100

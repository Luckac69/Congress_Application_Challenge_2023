extends CharacterBody2D

@onready var animation = $AnimationPlayer


var HEALTH = 100
var can_take_damage = true
var player_alive = true
var enemy_in_attack_zone = false
const SPEED = 300.0

func _physics_process(delta):
	#every frame these things run
	deal_damage()
	player_move()

	#if player health is 0 then kill player
	if HEALTH <= 0:
		player_alive = false 
		HEALTH = 0
		print("player killed")
		self.queue_free()


func player_move():
	var yDirection = Input.get_axis("up","down")
	var WizardSprite = $Wizard
	if yDirection:
		velocity.y = yDirection * SPEED
	else:
		velocity.y = move_toward(velocity.y,0,SPEED)

	var xDirection = Input.get_axis("left", "right")

	if xDirection:
		velocity.x = xDirection * SPEED
		if xDirection > 0:
			WizardSprite.flip_h = false
		else:
			WizardSprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if yDirection or xDirection:
		animation.play("Walk")
	else:
		animation.play("Idle")

	move_and_slide()


func update_health():
	var healthbar = $healthbar

	healthbar.value = HEALTH

	if HEALTH >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true


func _on_regin_timer_timeout():
	if HEALTH < 100:
		HEALTH = HEALTH + 5
		if HEALTH > 100:
			HEALTH = 100

func _on_player_hitbox_area_entered(body):
	print(body)
	if body.get_parent().is_in_group("Enemy"):
		enemy_in_attack_zone = true

func _on_player_hitbox_area_exited(body):
	if body.get_parent().is_in_group("Enemy"):
		enemy_in_attack_zone = false

func deal_damage():
	if enemy_in_attack_zone == true:
		if can_take_damage == true:
			HEALTH = HEALTH - 20
			$"/root/GlobalScript".camera.shake(0.2, 3)
			animation.play("Damage")
			$DamageTakeCooldown.start()
			can_take_damage = false
			print("Player Health is ", HEALTH)
			if HEALTH <= 0:
				self.queue_free()

func _on_damage_take_cooldown_timeout():
	can_take_damage = true


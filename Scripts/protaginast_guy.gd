extends CharacterBody2D

@onready var animation = $AnimationPlayer


@export var health = 100
@export var speed = 300.0
var can_take_damage = true
var player_alive = true
var enemy_in_attack_zone = false
var can_shoot_fireball = true
var can_shoot_explosion = true

var can_shoot_lightning = true

var bullet_prefab = preload("res://fireball.tscn")
var explosion_prefab = preload("res://explosion.tscn")

var lightning_prefab = preload("res://lightning.tscn")

const REGEN = 5

func _input(event):
	if event.is_action_pressed("Shoot"):
		if can_shoot_fireball == true:
			#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			can_shoot_fireball = false
			$FireballShootCooldown.start()
			create_bullet()
	
	if event.is_action_pressed("Explode"):
		if can_shoot_explosion == true:
			#if event is InputEventKey:
			can_shoot_explosion = false
			$ExplosionShootCooldown.start()
			create_explosion()
	
	
	if event.is_action_pressed("Lightning"):
		if can_shoot_lightning == true:
			can_shoot_lightning = false
			$LightningShootCooldown.start()
			create_lightning()

func create_bullet():
	var bullet = bullet_prefab.instantiate()
	# Set the bullet's position to the player's position or the gun's position.
	# Add the bullet as a child of the current scene.
	get_parent().add_child(bullet)
	bullet.position = position
	bullet.velocity = get_global_mouse_position() - bullet.position
	bullet.look_at(get_global_mouse_position())

func create_explosion():
	var explosion = explosion_prefab.instantiate()
	get_parent().add_child(explosion)
	explosion.position = position
	explosion.velocity = get_global_mouse_position() - explosion.position
	explosion.look_at(get_global_mouse_position())

func create_lightning():
	var lightning = lightning_prefab.instantiate()
	get_parent().add_child(lightning)
	lightning.position = position
	lightning.velocity = get_global_mouse_position() - lightning.position
	lightning.look_at(get_global_mouse_position())



func _physics_process(delta):
	#every frame these things run
	deal_damage()
	player_move()
	if $ControlHealthBar.is_visible():
		health += REGEN*delta
		$ControlHealthBar.set_value(health)
	#if player health is 0 then kill player
	if health <= 0:
		player_alive = false 
		health = 0
		print("player killed")
		self.queue_free()


func player_move():
	var yDirection = Input.get_axis("up","down")
	var WizardSprite = $Wizard
	if yDirection:
		velocity.y = yDirection * speed
	else:
		velocity.y = move_toward(velocity.y,0,speed)

	var xDirection = Input.get_axis("left", "right")

	if xDirection:
		velocity.x = xDirection * speed
		if xDirection > 0:
			WizardSprite.flip_h = false
		else:
			WizardSprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

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
		health += 100
		if health > 100:
			health = 100

func _on_player_hitbox_area_entered(body):
	if body.get_parent().is_in_group("Enemy"):
		enemy_in_attack_zone = true

func _on_player_hitbox_area_exited(body):
	if body.get_parent().is_in_group("Enemy"):
		enemy_in_attack_zone = false

func deal_damage():
	if enemy_in_attack_zone == true:
		if can_take_damage == true:
			health -= 20
			$"/root/GlobalScript".camera.shake(0.2, 3)
			animation.play("Damage")
			$ControlHealthBar.set_value(health)
			$DamageTakeCooldown.start()
			can_take_damage = false
			print("Player Health is ", health)
			if health <= 0:
				self.queue_free()

func _on_damage_take_cooldown_timeout():
	can_take_damage = true

func _on_fireball_shoot_cooldown_timeout():
	can_shoot_fireball = true

func _on_explosion_shoot_cooldown_timeout():
	can_shoot_explosion = true

func _on_lightning_shoot_cooldown_timeout():
	can_shoot_lightning = true

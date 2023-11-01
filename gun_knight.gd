extends CharacterBody2D

# var target = player
@onready var animation = $AnimationPlayer
@onready var target = get_parent().get_node("Protaginast_guy")
@export var speed : float = 250
@export var health : float = 100
@export var damage : float = 20
@export var EnemySprite : Sprite2D

var player_inattack_zone = false
var can_take_damage = true
var enemy_alive = true
var can_shoot_pellet = true

var pellet_prefab = preload("res://pellet.tscn")
var experience_prefab = preload("res://experience.tscn")

func _ready():
	$PelletTimer.start()
	add_to_group("Enemy")

func _physics_process(delta):

	if target == null: target = get_tree().get_first_node_in_group("Player")
	if target != null:
		animation.play("walk")
		velocity = position.direction_to(target.position) * speed
		if velocity.x > 1:
			EnemySprite.flip_h = true
		else:
			EnemySprite.flip_h = false
		move_and_slide()
		#position += (target.position - position).normalized() * SPEED
	# var player = get_parent().get_node("Protaginast_guy")
	# var target = player

func update_health():
	var healthbar = $HealthBar
	
	healthbar.value = health
	
	if health < 100:
		healthbar.visible = true
	else:
		healthbar.visible = false
	
	
func _on_enemy_hitbox_area_entered(body):
	if body.get_parent().is_in_group("Player"):
		player_inattack_zone = true
	if body.get_parent().is_in_group("Bullet"):
		take_damage(10)
	if body.get_parent().is_in_group("Explosion"):
		take_damage(60)
	if body.get_parent().is_in_group("Spikes"):
		take_damage(10)
		speed = 250
		$SlowDuration.start()
		take_damage(80)
	if body.get_parent().is_in_group("Lightning"):
		take_damage(100)
		
	
func _on_enemy_hitbox_area_exited(body):
	if body.get_parent().is_in_group("Player"):
		player_inattack_zone = false
		
func take_damage(damage: float):
		if can_take_damage == true:
			health = health - damage
			update_health()
			$AudioStreamPlayer.play()
			$ControlHealthBar.set_value(health)
			$DamageTakeCooldown.start()
			can_take_damage = false
			if health <= 0:
				enemy_alive = false
				create_experience()
				self.queue_free()

func _on_damage_take_cooldown_timeout():
	can_take_damage = true

func _on_slow_duration_timeout():
	speed = 450

func create_experience():
	var experience = experience_prefab.instantiate()
	get_parent().add_child(experience)
	experience.position = position

func trigger_pellet():
	if can_shoot_pellet == true:
		can_shoot_pellet == false
		$PelletTimer.start()
		create_pellet()

func create_pellet():
	var pellet = pellet_prefab.instantiate()
	print("created bullet")
	print(pellet)
	get_parent().add_child(pellet)
	pellet.position = position
	pellet.velocity = target.position - pellet.position
	pellet.look_at(target.position)

func _on_pellet_timer_timeout():
	trigger_pellet()


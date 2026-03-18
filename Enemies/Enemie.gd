extends CharacterBody2D

class_name Enemie

var speed = 30

var player_chase = false

var player : Player = null
var ChasedPlayer: Player = null 

var attack_timer = 1
var cooldown = 1
var atack = false
var death = false

@export var health := 100


var patrol_start_position := Vector2.ZERO
var patrol_direction := 1  # 1 = rechts, -1 = links
@export var patrol_distance := 10.0  # wie weit hin und her

var random_offset = 0.0
var time_passed = 0.0


@export var knockback_strength: float = 2000
@export var knockback_duration: float = 0.15
var is_knocked_back = false



func _physics_process(delta):
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if attack_timer > 0 and player_chase:
		attack_timer -= delta
		print(attack_timer)
	
		
	if player_chase:
		$AnimatedSprite2D.play("walk")
		if(ChasedPlayer.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
		position.x+=(ChasedPlayer.position.x-position.x)/speed
		
	
	
	if player_chase == false:
		noPlayerNear(delta)
	
	
	
	
	move_and_slide()
	
	healthCheck()
	can_atack()
	

func _on_area_2d_body_entered(body):
	if body is Player:
		player_chase = true
		ChasedPlayer = body
		


func _on_area_2d_body_exited(body):
	if body == ChasedPlayer:
		ChasedPlayer = null
		player_chase = false
		


func _on_atack_body_entered(body) -> void:
	if body is Player:
		player = body
		atack = true
		



func _on_atack_body_exited(body) -> void:
	if body == player:
		attack_timer = 0
		atack = false


func can_atack():
	if player and atack == true and attack_timer <= 0 and death == false:
		attack_timer = cooldown
		player.get_damage(5)
		
		


func take_damage(amount: int):
	health -= amount
	$ProgressBar.value = health

		
func healthCheck() -> void:
	if health <= 0:
		atack = false
		death = true
	
		queue_free()

func apply_knockback(from_position: Vector2) -> void:
	if is_knocked_back:
		return

	is_knocked_back = true
	var direction = sign(global_position.x - from_position.x)
	velocity.x = direction * knockback_strength
	
	move_and_slide()
	
	await get_tree().create_timer(knockback_duration).timeout
	velocity.x = 0
	is_knocked_back = false





func noPlayerNear(delta):
	$AnimatedSprite2D.play("walk")
	
	# Sprite drehen je nach Richtung
	$AnimatedSprite2D.flip_h = patrol_direction < 0
	
	# Bewegung
	velocity.x = patrol_direction * speed
	position.x += velocity.x * delta
	
	# Prüfen, ob Grenze erreicht wurde
	if position.x > patrol_start_position.x + patrol_distance:
		patrol_direction = -1
	elif position.x < patrol_start_position.x - patrol_distance:
		patrol_direction = 1

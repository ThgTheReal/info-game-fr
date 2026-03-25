extends CharacterBody2D

class_name Player

@export var health = 100
@export var stamina = 100

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var RayL = $ClimbL
@onready var RayR = $ClimbR




func updateTextures():
	$CanvasLayer/Control/Health.value = health
	$CanvasLayer/Stamina.value = stamina

func _ready() -> void:
	pass
func _physics_process(delta: float) -> void:
	changeCat()
	
	$CanvasLayer/Control/RoundCounter.text = "Round: " + str(GlobalVariables.Round)
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	
	

	
	
	TextureAnimation(direction)
	
	Attack()
	
	Klettern()
	
	useStamina(delta)
	
	
	die()
	move_and_slide()



var catColor = "Orange"
@onready var animation = $AnimatedSprite2D


func changeCat():
	if Input.is_key_pressed(KEY_1):
		catColor = "Orange"
	elif Input.is_key_pressed(KEY_2):
		catColor = "Weiß"
	elif Input.is_key_pressed(KEY_3):
		catColor = "Schwarz"

func TextureAnimation(direction):
	if attacking == true:
		animation.play("attack" + catColor)
		return
		
	if direction == -1:
		$AnimatedSprite2D.flip_h = false
	if  direction == 1:
		$AnimatedSprite2D.flip_h = true
	animation.play("walk" + catColor)
	
	if direction == 0:
		animation.play("sit" + catColor)



var  IsKlettern = false

func useStamina(delta):
	if IsKlettern and stamina > 0:
		stamina -= 10 * delta
	
	elif !IsKlettern and stamina < 100:
		stamina += 2 * delta
	
	stamina = clamp(stamina, 0, 100)
	$CanvasLayer/Stamina.value = stamina
	





func Klettern():
	
	if is_on_floor():
		IsKlettern = false
	
	if stamina > 0:
		
		if not is_on_floor():
			if (RayL.is_colliding()  or RayR.is_colliding()) and Input.is_action_pressed("Jump"):
				velocity.y = -150
				IsKlettern = true
			elif (RayL.is_colliding() or RayR.is_colliding()) and !Input.is_action_pressed("Jump") and !Input.is_action_pressed("Sneak"):
				velocity.y = 0
				IsKlettern = true
			elif (RayL.is_colliding() or RayR.is_colliding()) and Input.is_action_pressed("Sneak") and !Input.is_action_pressed("Jump"):
				velocity.y = 200
				IsKlettern = true





@onready var damageShader = $AnimatedSprite2D.material

func get_damage(damage) -> void:
	damageShader.set_shader_parameter("flash_strength", 0.5)
	await get_tree().create_timer(0.1).timeout
	damageShader.set_shader_parameter("flash_strength", 0.0)
	
	health = health - damage
	$CanvasLayer/Control/Health.value = health
	die()

func die():
	if health <= 0 or position.y >= 320:
		get_tree().change_scene_to_file("res://EndScreen/EndScreen.tscn")
		#position = Vector2(0,0)
		#health = 100
		#$CanvasLayer/Control/Health.value = health

var EnemieBody = []


var attacking = false


func Attack():
	if Input.is_action_just_pressed("Attack") and attacking == false:
		attacking = true
		for enemie in EnemieBody:
			enemie.take_damage(5)
			enemie.apply_knockback(position)
		$AttackCooldown.start()
	

func CheckIfEnemieInAtack(body: Node2D) -> void:
	if body is Enemie or CommmunismRats:
		EnemieBody.append(body)

func EnemieLeaveArea(body: Node2D) -> void:
	if body is Enemie or CommmunismRats:
		EnemieBody.erase(body)


func _on_attack_cooldown_timeout() -> void:
	attacking = false
	

extends CharacterBody2D

class_name Player

@export var health = 100
@export var stamina = 100

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var RayL = $ClimbL
@onready var RayR = $ClimbR





func updateTextures():
	$Health.value = health
	$CanvasLayer/Stamina.value = stamina

func _ready() -> void:
	pass
func _physics_process(delta: float) -> void:
	
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
	
	Klettern()
	
	useStamina(delta)
	
	Attack()
	
	move_and_slide()


@onready var animation = $AnimatedSprite2D
func TextureAnimation(direction):
	
	if direction == 0:
		animation.play("sitWeiß")
	
	if direction == -1:
		animation.play("walkLeftWeiß")
	elif  direction == 1:
		animation.play("walkRightWeiß")

	

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


var EnemieBody = null




func get_damage(damage) -> void:
	health = health - damage
	$Health.value = health
	die()

func die():
	if health <= 0:
		position = Vector2(0,0)
		health = 100
		$Health.value = health


func Attack():
	if Input.is_action_just_pressed("Attack"):
		if EnemieBody != null:
			EnemieBody.take_damage(5)



func CheckIfEnemieInAtack(body: Node2D) -> void:
	if body is Enemie:
		EnemieBody = body

func EnemieLeaveArea(body: Node2D) -> void:
	if body is Enemie:
		EnemieBody = null

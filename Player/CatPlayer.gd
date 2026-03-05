extends CharacterBody2D

class_name Player

@export var health = 100
@export var stamina = 100

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var RayL = $ClimbL
@onready var RayR = $ClimbR







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
		
	
	#TextureAnimation(direction)
	
	Klettern()
	
	
	
	move_and_slide()



#func TextureAnimation(direction):
#			
#	if direction != 0:
#		$AnimatedSprite2D.play()
#	
#	if direction == 1:
#		$AnimatedSprite2D.flip_h = false
#	elif  direction == -1:
#		$AnimatedSprite2D.flip_h = true
#	else:
#		$AnimatedSprite2D.stop()
#	



func useStamina():
	if IsKlettern == false:
		stamina =+ 1
		await get_tree().create_timer(0.5).timeout
	
	if Klettern:
		stamina =- 10
		await get_tree().create_timer(1.0).timeout


var  IsKlettern = false

func Klettern():
	if stamina < 0:
		pass
	
	if not is_on_floor():
		if (RayL.is_colliding()  or RayR.is_colliding()) and Input.is_action_pressed("Jump"):
			velocity.y = -150
			IsKlettern = true
		elif RayL.is_colliding() or RayR.is_colliding() and !Input.is_action_pressed("Jump") and !Input.is_action_pressed("Sneak"):
			velocity.y = 0
			IsKlettern = true
		elif RayL.is_colliding() or RayR.is_colliding() and Input.is_action_pressed("Sneak") and !Input.is_action_pressed("Jump"):
			velocity.y = 200
			IsKlettern = true
	if is_on_floor():
		IsKlettern = false


#var EnemieBody:Enemie = null

#func Attack():
#	pass


func get_damage(damage) -> void:
	health = health - damage



func CheckIfEnemieInAtack(body: Node2D) -> void:
	pass
#	if body is Enemie:
#		EnemieBody = body




func EnemieLeaveArea(body: Node2D) -> void:
	pass
#	if body is Enemie:
#		EnemieBody = null

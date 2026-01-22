extends CharacterBody2D

class_name CatS



const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var RayL = $ClimbL
@onready var RayR = $ClimbR

func _ready() -> void:
	RayL.enabled = true

func _physics_process(delta: float) -> void:
	
	# GDScript (z.B. in _process)
	if $Sky:
		var shader_material = $Sky.material as ShaderMaterial
		shader_material.set_shader_parameter("player_velocity", velocity)

	
	
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
	
	
	
	
	Klettern()
	
	
	
	move_and_slide()





func Klettern():
	if not is_on_floor():
		if RayL.is_colliding() and Input.is_action_pressed("Jump"):
			velocity.y = -350
		elif RayR.is_colliding() and Input.is_action_pressed("Jump"):
			velocity.y = -350

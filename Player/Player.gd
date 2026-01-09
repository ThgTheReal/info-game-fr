extends CharacterBody3D

@export var speed := 3.0
@export var jump_velocity := 4.0
@export var mouse_sensitivity := 0.002

@export var max_side_pitch := 0.15 # in radians, ~8,6° horizontal max
@export var side_lerp_speed := 5.0 # wie schnell sich die Kamera zurückstellt

@onready var camera_arm := $CameraArm  # SpringArm3D
@onready var camera := $CameraArm/Camera3D

var pitch := 0.0        # vertikale Rotation
var side_offset := 0.0  # horizontale minimale Abweichung


@onready var magic_popup := $CanvasLayer/MagicPopup



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	magic_popup.visible = false


var magic = false

func toggle_magic_popup():
	magic_popup.visible = !magic_popup.visible

	if magic_popup.visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		magic_popup.draw_area.reset_drawing()
		set_physics_process(false)
		magic = true
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		set_physics_process(true)
		magic = false

func _on_button_pressed() -> void:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		set_physics_process(true)
		magic = false
		
		
		
		
func _exit_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event.is_action_released("open_magic") :
		toggle_magic_popup()
		
	
	
	if magic_popup.visible:
		return
	
	
	if event is InputEventMouseMotion:
		# Spieler dreht sich nach links/rechts (Yaw)
		rotate_y(-event.relative.x * mouse_sensitivity)

		# Kamera minimal nach links/rechts (Side-Peek)
		var horizontal_input = event.relative.x * mouse_sensitivity
		side_offset = clamp(side_offset + horizontal_input * 0.2, -max_side_pitch, max_side_pitch)

		# Kamera hoch/runter (Pitch)
		pitch -= event.relative.y * mouse_sensitivity
		pitch = clamp(pitch, deg_to_rad(-70), deg_to_rad(70))

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Movement
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction != Vector3.ZERO:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

	# Side-Offset langsam zurücksetzen (damit es smooth wirkt)
	side_offset = lerp(side_offset, 0.0, delta * side_lerp_speed)


	# Kamera-Rotation anwenden: vertikal (Pitch) + minimal horizontal (Side)
	camera_arm.rotation = Vector3(pitch, side_offset, 0)

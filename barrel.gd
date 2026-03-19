extends CharacterBody2D
class_name rat_barrel

var rat = preload("res://Enemies/Enemie_Jannik.tscn")

func _ready() -> void:
	velocity.x = randf_range(-1000,1000)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if is_on_floor():
		var ratInstance:Enemie = rat.instantiate()
		ratInstance.global_position = global_position
		get_parent().add_child(ratInstance)
		queue_free()

	move_and_slide()

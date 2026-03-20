extends CharacterBody2D
class_name rat_barrel

var rat = preload("res://Enemies/Enemie_Jannik.tscn")



func _ready() -> void:
	velocity.x = randf_range(-500,500)


func _physics_process(delta: float) -> void:
	rotate(0.1)
	# Add the gravity.
	if not is_on_floor():
		velocity += (get_gravity() * delta) / 2

	# Handle jump.
	if is_on_floor():
		if player:
			player.get_damage(10)
			
		var ratInstance:Enemie = rat.instantiate()
		ratInstance.global_position = global_position
		get_parent().add_child(ratInstance)
		queue_free()
		
	move_and_slide()




var player = null
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		player = null

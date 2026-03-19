extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


@export var barrel = preload("res://Barrel.tscn")
func _on_timer_timeout() -> void:
	for spawn_point in get_children():
		if spawn_point.name.begins_with("B"):
			var barrelInst:rat_barrel = barrel.instantiate()  
			barrelInst.global_position = spawn_point.global_position
			add_child(barrelInst)
			

	$Timer.start()

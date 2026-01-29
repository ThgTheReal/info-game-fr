extends Node2D

class_name CloudType1

var PLAYER = preload("res://Player/CatPlayer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player:CatS = PLAYER.instantiate()
	if player:
		if global_position.x > player.global_position.y + 2500:
			global_position = Vector2(player.global_position.x - 2500,randfn(50,200))
			print("swap")

extends Node2D
class_name CloudType1

@onready var PLAYER = preload("res://Player/CatPlayer.tscn") 
# adjust path to match your scene tree

func _process(_delta: float) -> void:
	var player:Player = PLAYER.instantiate()
	
	if not player:
		return
		
	if global_position.x > player.global_position.x + 2500:
		global_position = Vector2(player.global_position.x - 2500,randfn(50, 200))
		

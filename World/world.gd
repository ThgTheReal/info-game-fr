extends Node2D


# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	var Player:CatS = preload("res://Player/StarkeKatze/CatPlayer.tscn").instantiate()
	
	add_child(Player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Stats.text = "Rats killed: " + str(GlobalVariables.RatKills)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_redo_pressed() -> void:
	GlobalVariables.RatKills = 0
	GlobalVariables.Round = 0
	GlobalVariables.comunismRatHealth = 0
	GlobalVariables.comunismRatMaxHealth = 0
	get_tree().change_scene_to_file("res://World/WorldElements/StartWorld.tscn")

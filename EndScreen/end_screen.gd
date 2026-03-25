extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Stats.text = "Rats killed: " + str(GlobalVariables.RatKills)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Area2D


var heal= false
var player = null

func _process(delta: float) -> void:
	if heal == true:
		player.health = player.health + 10


func _on_body_entered(body: Player) -> void:
		heal = true
		player = body

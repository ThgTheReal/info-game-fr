extends Area2D


var heal= false
var player = null

func _process(delta: float) -> void:
	if heal == true:
		player.health = player.health + 10
		player.updateTextures()

func _on_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		heal = true
		player = body


func _on_body_exited(body: Node2D) -> void:
	if body == player:
		heal = false
		player = null

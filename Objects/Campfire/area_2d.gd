extends Area2D

var stamina =false
var heal= false
var player = null

func _process(delta: float) -> void:
	if heal == true:
		if player.health <= 100:
			player.health = player.health + 1
			player.stamina = player.stamina + 1
			player.updateTextures()

func _on_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		heal = true
		player = body


func _on_body_exited(body: Node2D) -> void:
	if body == player:
		heal = false
		stamina = false
		player = null

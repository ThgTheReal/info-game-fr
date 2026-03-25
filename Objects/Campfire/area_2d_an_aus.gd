extends Node2D


func _ready() -> void:
		$AnimatedSprite2D.play("Aus")

func _on_body_entered(body: Player) -> void:
	$AnimatedSprite2D.play("An")
	$Timer.start()
	
func _on_body_exited(body: Player) -> void:
	$AnimatedSprite2D.play("Aus_gehn")
	
func _on_timer_timeout() -> void:
	$AnimatedSprite2D.play("Aus_gehn")

extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SettingsMenue.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://World/WorldElements/StartWorld.tscn")


func _on_settings_pressed() -> void:
	$SettingsMenue.show()
	$Menue.hide()




func _on_back_pressed() -> void:
	$SettingsMenue.hide()
	$Menue.show()

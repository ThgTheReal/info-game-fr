extends ParallaxBackground

@onready var Cloud = preload("res://World/WorldElements/cloud.tscn")

@export var drift_speed := Vector2(50.0, 0.0) # Grundbewegung
@export var float_amplitude := 1.0            # Schweben
@export var float_speed := 0.2              # Langsamkeit

var time := 0.0
var base_offset := Vector2.ZERO



func _ready() -> void:
	generateClouds()

func _process(delta: float) -> void:
	time += delta
	base_offset += drift_speed * delta

	for ParaLayer in get_children():
		if ParaLayer is ParallaxLayer:
			var cloud_offset := base_offset
			cloud_offset.x += sin(time * float_speed) * float_amplitude

			# Pixel-Art-Schutz
			ParaLayer.motion_offset = cloud_offset.round()
	pass




func CloudCycle():   #wenn wolken zu weit vom player entfernt gehen sei zurück zum start
	for Childs in get_children():
		for LayerClouds in Childs.get_children():
			var PLAYER = preload("res://Player/CatPlayer.tscn").instantiate()
			



func generateClouds():  #mit Ki suport
	for i in 10:
		for CloudLayer in get_children():
			if CloudLayer is ParallaxLayer:
				var new_cloud = Cloud.instantiate()
				
				var random_x = randf_range(-2048, 2048) 
				var random_y = randf_range(75, 200)  
				
				new_cloud.position = Vector2(random_x, random_y)
			
				CloudLayer.add_child(new_cloud)
	pass

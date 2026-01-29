extends ParallaxBackground

@onready var Cloud = preload("res://cloud.tscn").instantiate()

@export var drift_speed := Vector2(50.0, 0.0) # Grundbewegung
@export var float_amplitude := 1.0            # Schweben
@export var float_speed := 0.2              # Langsamkeit

var time := 0.0
var base_offset := Vector2.ZERO

func _ready() -> void:
	for CloudLayer in get_children():
		if CloudLayer is ParallaxLayer:
			# 1. Neue Instanz der Wolke erstellen
			var new_cloud = Cloud
			
			# 2. Zufällige Position definieren
			# Hier musst du deine gewünschten Grenzen angeben (z.B. Bildschirmgröße)
			var random_x = randf_range(0, 1152) # Beispielbreite
			var random_y = randf_range(0, 648)  # Beispielhöhe
			
			new_cloud.position = Vector2(random_x, random_y)
			
			# 3. Wolke als Kind hinzufügen
			CloudLayer.add_child(new_cloud)
	pass


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

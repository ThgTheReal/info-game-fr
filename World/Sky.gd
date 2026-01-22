extends Node2D

@export var sky_color : Color = Color(0.529, 0.808, 0.922) # Himmelblau
@export var cloud_texture : Texture2D          # Pixelart Wolke
@export var cloud_speed : float = 20.0         # Pixel/Sekunde
@export var cloud_count : int = 5              # Anzahl Wolken

var cloud_positions : Array[Vector2] = []

func _ready():
	# Zufällige Startpositionen für die Wolken
	for i in range(cloud_count):
		var x = randf() * get_viewport_rect().size.x
		var y = randf() * get_viewport_rect().size.y * 0.5  # Obere Hälfte des Bildschirms
		cloud_positions.append(Vector2(x, y))

func _process(delta):
	var screen_width = get_viewport_rect().size.x
	
	# Wolken bewegen
	for i in range(cloud_positions.size()):
		cloud_positions[i].x -= cloud_speed * delta
		if cloud_positions[i].x < -cloud_texture.get_width():
			cloud_positions[i].x = screen_width
	
	queue_redraw()  # Ruft _draw() auf

func _draw():
	var screen_size = get_viewport_rect().size
	
	# Himmel malen
	draw_rect(Rect2(Vector2.ZERO, screen_size), sky_color)
	
	# Wolken malen
	for pos in cloud_positions:
		draw_texture(cloud_texture, pos)

extends Control

# Zeichnungsvariablen
var drawing: bool = false
var points: PackedVector2Array = []

# Größe des Zeichenbereichs
var area_size: Vector2 = Vector2(256, 256)

func reset_drawing() -> void:
	points.clear()
	queue_redraw()  # damit die Linien auch sofort verschwinden


func get_points() -> PackedVector2Array:
	return points

# ---------------------
# Input abfangen
# ---------------------
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:  # <-- hier
			drawing = event.pressed
			if drawing:
				points.clear()

	if event is InputEventMouseMotion and drawing:
		points.append(event.position)
		queue_redraw()

# ---------------------
# Zeichnen der Linien
# ---------------------
func _draw() -> void:
	for i in range(points.size() - 1):
		draw_line(points[i], points[i + 1], Color.WHITE, 8.0)

# ---------------------
# Liefert Image aus der Zeichnung
# ---------------------
func get_draw_image() -> Image:
	var img: Image = Image.create(int(area_size.x), int(area_size.y), false, Image.FORMAT_RGB8)

	# Hintergrund schwarz
	for x in range(img.get_width()):
		for y in range(img.get_height()):
			img.set_pixel(x, y, Color.BLACK)

	# Punkte skalieren
	var scale_x: float = img.get_width() / area_size.x
	var scale_y: float = img.get_height() / area_size.y

	for i in range(points.size() - 1):
		var p0_scaled := Vector2(points[i].x * scale_x, points[i].y * scale_y)
		var p1_scaled := Vector2(points[i + 1].x * scale_x, points[i + 1].y * scale_y)
		draw_line_on_image(img, p0_scaled, p1_scaled, Color.WHITE, 8)

	return img

# ---------------------
# Linie auf Image zeichnen
# ---------------------
func draw_line_on_image(img: Image, p0: Vector2, p1: Vector2, color: Color, width: int) -> void:
	var delta: Vector2 = p1 - p0
	var steps: int = int(delta.length())
	if steps == 0:
		return
	var step: Vector2 = delta / float(steps)
	for i in range(steps):
		var pos: Vector2 = p0 + step * i
		for dx in range(-width/2, width/2 + 1):
			for dy in range(-width/2, width/2 + 1):
				var x: int = clamp(int(pos.x) + dx, 0, img.get_width() - 1)
				var y: int = clamp(int(pos.y) + dy, 0, img.get_height() - 1)
				img.set_pixel(x, y, color)

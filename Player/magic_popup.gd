extends Control

@onready var draw_area: Control = $DrawArea
@onready var reference: TextureRect = $Reference

func _ready() -> void:
	visible = false
	


func _on_confirm_btn_pressed() -> void:
	if points_empty():
		print("⚠ Du hast nichts gezeichnet!")

	if not reference.texture:
		print("⚠ Kein Referenzbild gesetzt!")
		return

	var player_img: Image = draw_area.get_draw_image()
	var ref_img: Image = reference.texture.get_image()

	var score: float = compare_loose(player_img, ref_img)
	print("Score:", score)

	if score < 0.21:
		print("Perfekt")
	elif score < 0.40:
		print("Nicht Schlecht")
	elif score < 0.70:
		print("Du has tnoch viel zu lernen")
	else:
		print("Miserabel")
	
	
	visible = false

# Prüfen, ob Spieler Punkte gezeichnet hat
func points_empty() -> bool:
	return draw_area.get_points().size() < 2

# Vergleichsfunktion (Score)
func compare_loose(player_img: Image, ref_img: Image) -> float:
	player_img.resize(64, 64)
	ref_img.resize(64, 64)

	var diff: float = 0.0
	var total_ref_pixels: int = 0

	for x in range(64):
		for y in range(64):
			var ref_val: float = ref_img.get_pixel(x, y).r
			var player_val: float = player_img.get_pixel(x, y).r
			if ref_val > 0.1:
				diff += abs(player_val - ref_val)
				total_ref_pixels += 1

	if total_ref_pixels == 0:
		return 1.0

	return diff / float(total_ref_pixels)

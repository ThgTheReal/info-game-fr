shader_type canvas_item;

uniform float flash_strength : hint_range(0.0, 1.0) = 0.0;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    
    // Weißes Blinken (Mischen mit Weiß)
    vec3 flash_color = mix(tex_color.rgb, vec3(1.0), flash_strength);
    
    COLOR = vec4(flash_color, tex_color.a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

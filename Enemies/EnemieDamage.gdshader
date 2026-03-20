shader_type canvas_item;

uniform float flash_strength : hint_range(0.0, 1.0) = 0.0;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    
    // Rot statt Weiß
    vec3 red_tint = vec3(1.0, 0.2, 0.2);
    
    vec3 final_color = mix(tex_color.rgb, red_tint, flash_strength);
    
    COLOR = vec4(final_color, tex_color.a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

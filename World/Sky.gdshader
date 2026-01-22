shader_type canvas_item;

// Pixelgröße Himmel (Pixel-Art)
uniform float pixel_size = 4.0; // je größer, desto größer die Pixelblöcke

// Farben Himmel
uniform vec4 sky_bottom_color : source_color = vec4(0.45, 0.7, 1.0, 1.0);
uniform vec4 sky_top_color    : source_color = vec4(0.1, 0.25, 0.6, 1.0);

// Wolkenfarbe & Parameter
uniform vec4 cloud_color      : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float cloud_density = 0.55;  // Wolkendichte
uniform float cloud_scale = 6.0;     // Anzahl der Wolken pro Bildschirm
uniform float cloud_roundness = 0.5; // 0-1, wie rund die Wolkenblöcke sind

// Wolkenbewegung
uniform float cloud_speed = 0.02;
uniform vec2 cloud_offset = vec2(0.0, 0.0);
uniform vec2 player_velocity = vec2(0.0, 0.0);

// Hash-Funktion
float hash(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 78.233);
    return fract(p.x * p.y);
}

// Noise
float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);

    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(a, b, u.x) +
           (c - a) * u.y * (1.0 - u.x) +
           (d - b) * u.x * u.y;
}

void fragment() {
    // Pixelisierte UV für Himmel (Pixel-Art)
    vec2 sky_uv = floor(UV * pixel_size) / pixel_size;
    vec4 sky = mix(sky_bottom_color, sky_top_color, sky_uv.y);

    // Wolken nur im oberen Drittel
    float clouds = 0.0;
    if (UV.y < 0.33) {
        // Pixelisierte UV für Wolken
        vec2 cloud_uv = floor(UV * pixel_size) / pixel_size;
        cloud_uv *= cloud_scale;

        // Bewegung
        cloud_uv.x += TIME * cloud_speed;
        cloud_uv += cloud_offset;
        cloud_uv += player_velocity * 0.5;

        // Noise
        float n = noise(cloud_uv);

        // Runde Pixelblöcke
        vec2 block_pos = fract(cloud_uv) - 0.5;
        float round_mask = 1.0 - length(block_pos) * 2.0;
        round_mask = clamp(round_mask / cloud_roundness, 0.0, 1.0);

        clouds = step(cloud_density, n) * round_mask;
    }

    COLOR = mix(sky, cloud_color, clouds);
}

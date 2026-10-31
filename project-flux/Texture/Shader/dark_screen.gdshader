shader_type canvas_item;

uniform vec2 center_px = vec2(0.0);
uniform vec2 viewport_px = vec2(1152.0, 864.0);
uniform float radius_px = 200.0;
uniform float soft_px = 150.0;
uniform float darkness : hint_range(0.0, 1.0) = 0.65;
uniform vec4 tint : source_color = vec4(0.0, 0.0, 0.05, 1.0);


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 p = UV * viewport_px;
    float d = distance(p, center_px);
    float k = smoothstep(radius_px, radius_px + soft_px, d);
    COLOR = vec4(tint.rgb, k * darkness);
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}

shader_type canvas_item;

global uniform vec2 player_pos;
global uniform float fow_radius;
global uniform float fow_brouillard;

varying vec2 world_pos;

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
	// Called for every vertex the material is visible on.
}

void fragment() {
	float dist = distance(world_pos, player_pos);
    COLOR.a *= 1.0 - smoothstep(fow_radius - fow_brouillard, fow_radius, dist);
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}

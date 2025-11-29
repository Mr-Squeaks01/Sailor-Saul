shader_type canvas_item;

uniform bool active;
uniform float intensity;
uniform float speed;
uniform vec4 def_color: source_color;
uniform vec4 color: source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	if (COLOR == def_color && active) {
		COLOR = mix(color, def_color, cos(TIME * speed));
	}
	if (COLOR == vec4(0,0,0,1) && active) {
		COLOR = mix(vec4(0,0,0,1), mix(vec4(0,0,0,1),color, 0.9), cos(TIME * speed));
	}
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

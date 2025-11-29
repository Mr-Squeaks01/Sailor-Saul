shader_type canvas_item;
uniform vec4 Colors[4]: source_color;
uniform float brightness = 3;
uniform bool active;

void fragment() {
	// Called for every pixel the material is visible on.
	if (active) {
		int index = int(mix(0,4,sin(TIME * 25.0)));
		index = clamp(index, 0, 4);
		COLOR = texture(TEXTURE, UV);
		float sat = (COLOR.r + COLOR.b + COLOR.g) / 3.0;
		COLOR.rgb = vec3(sat) * vec3(brightness) * Colors[index].rgb;
	}
}
shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	vec4 colorModifier = mix(vec4(0.26, 0.28, 0.7, 1.0), vec4(1.0, 0.75, 0.2, 1.0), sin(TIME * 1.0 + SCREEN_UV.x * (1.0 + SCREEN_UV.y * 0.1) * 10.0));
	colorModifier = mix(colorModifier, vec4(1.0), 0.9);
	COLOR = textureLod(screen_texture, SCREEN_UV, 0.0) * colorModifier;
}

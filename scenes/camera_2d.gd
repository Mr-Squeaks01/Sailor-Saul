extends Camera2D

var shake_strength: float = 0
var shake_fade: float = 0

func shake(_max_shake, _shake_fade):
	shake_fade = _shake_fade
	shake_strength = _max_shake

func _process(delta: float) -> void:
	if shake_strength > 0:
		shake_strength = lerp(shake_strength, 0.0, shake_fade * delta)
		offset = Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))

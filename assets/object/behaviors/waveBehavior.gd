extends ObjectBehavior2D
class_name WaveBehavior
var time: int

func _ready() -> void:
	super()
	var tween = get_tree().create_tween()
	tween.tween_property(owner, "position:y", owner.position.y + amp, speed)
	tween.chain().tween_property(owner, "position:y", owner.position.y - amp, speed)
	tween.set_loops()
	await tree_exited
	tween.kill()

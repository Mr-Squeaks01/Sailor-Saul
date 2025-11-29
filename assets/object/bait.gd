extends Projectile2D
class_name Bait

static var count: int

var host: CharacterBody2D
var offscreen: bool
func  _ready() -> void:
	count += 1
	SfXmanager.play_sound("throw")

func _process(_delta: float) -> void:
	if offscreen and Input.is_action_just_pressed("throw"):
		count -= 1
		queue_free()
		


func _on_screen_exited() -> void:
	offscreen = true

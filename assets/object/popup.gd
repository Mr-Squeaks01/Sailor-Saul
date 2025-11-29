extends CharacterBody2D

func _ready() -> void:
	show()

func popup(message, pos):
	%pop_message.show()
	%pop_message.text = str(message) if message < 0 else  str("+", message)
	global_position = pos + Vector2(0, -50)

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	move_and_slide()


func _on_despawn_timer_timeout() -> void:
	queue_free()

extends CharacterBody2D
class_name Bomb

var ACTIVE = false

func activate():
	$BombSprite.play("default")
	show()
	ACTIVE = true

func _physics_process(delta: float) -> void:
	if ACTIVE:
		velocity += get_gravity() * delta
	else:
		velocity = Vector2.ZERO
	move_and_slide()


func _on_hitbox_body_entered(collider: Node2D) -> void:
	if collider is Player:
		$BombSprite.play("explosion")
		collider.hit(-20)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	get_parent().get_parent().get_node("Camera").shake(10.0, 10.0)
	SfXmanager.play_sound("splash")

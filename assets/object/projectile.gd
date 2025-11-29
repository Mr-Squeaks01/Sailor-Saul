extends CharacterBody2D
class_name Projectile2D

@export var has_gravity: bool

func _physics_process(delta: float) -> void:
	if has_gravity:
		velocity += get_gravity() * delta
	#velocity.x = lerp(velocity.x, 0.0, 0.5)
	move_and_slide()

func toggle_gravity():
	has_gravity = not has_gravity

func push(forceX, forceY):
	velocity = Vector2(forceX, forceY)

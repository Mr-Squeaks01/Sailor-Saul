extends CharacterBody2D
class_name Dustin

@export var Target: CharacterBody2D
@export var SPEED: float = 200
var direction: int
@export var active: bool
static var onscreen: bool
var offset: float = 0

func _ready() -> void:
	pass

func toggle_active():
	active = true
	if randi() % 2 == 0:
		offset = randf_range(50, 80)
	else:
		offset = -randf_range(50, 80)
	await get_tree().create_timer(1).timeout
	active = true

func _process(_delta: float) -> void:
	$AnimatedSprite2D.flip_h = direction
	if active:
		$Area2D/CollisionShape2D.disabled = false
		position.y = lerp(position.y, 623.0, 0.01)
		position.x = lerp(position.x, Target.position.x + offset, 0.05)
		
	else:
		$AnimatedSprite2D.play("default")
		Player.poisoned = false
		$Area2D/CollisionShape2D.disabled = true
		position.x = lerp(position.x, Target.position.x, 0.5)
		position.y = lerp(position.y, 707.0, 0.1)
	if active:
		Player.poisoned = true
	else:
		Player.poisoned = false
	
		
	move_and_slide()


func _on_collision(collider: Node2D) -> void:
	if collider:
		if collider is Bait:
			get_parent().get_node("Camera").shake(10.0, 10.0)
			$AnimatedSprite2D.play("bye")
			$Area2D/CollisionShape2D.set_deferred("disabled", true)
			await $AnimatedSprite2D.animation_finished
			active = false
	if collider:
		if collider is Player:
			collider.hit(-2)


func _on_radius_entered(collider: Node2D) -> void:
	if collider is Player:
		pass


func _onscreen() -> void:
	onscreen = true


func offscreen() -> void:
	onscreen = false

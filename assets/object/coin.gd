extends CharacterBody2D
class_name Coin
static var count: int = 0
@export var SPEED: float = 200.0
var active: bool
var bonus: bool

func _onscreen() -> void:
	if !active:
		active = true

func _enter_tree() -> void:
	count += 1

func _exit_tree() -> void:
	count -= 1


func _ready() -> void:
	if randi_range(0, 10) > 2:
		bonus = randi_range(0, 1)
	if bonus:
		$Sprite.material.set_shader_parameter("active", true)

func _offscreen() -> void:
	if active:
		SfXmanager.play_sound("splash", randf_range(1, 2))
		queue_free()

func _process(delta: float) -> void:
	velocity.y += SPEED * delta
	move_and_slide()

func _on_hitbox_collision(body: Node2D) -> void:
	if body is Player:
		Global.HEALTH += 2
		SfXmanager.play_sound("jump", 2)
		if not bonus:
			Global.COINS += 1
			Global.SCORE += 15
		else:
			Global.COINS += 10
			Global.SCORE += 50
		queue_free()

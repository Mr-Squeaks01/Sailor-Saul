extends CharacterBody2D
class_name Urchin
static var count: int
@export var LIMITS: Vector2
@export var SPEED: float
var VOLATILE: bool


var start_pos: Vector2
var has_start: bool

func _ready() -> void:
	start_pos = position
	SfXmanager.play_sound("throw", 0.5)
	if Global.WAVE > 3:
		VOLATILE = randi_range(0, 1)
	if VOLATILE:
		$AnimatedSprite2D.speed_scale = 2
		$AnimatedSprite2D.material.set_shader_parameter("active", true)
	else:
		$AnimatedSprite2D.speed_scale = 1
		$AnimatedSprite2D.material.set_shader_parameter("active", false)

func _physics_process(_delta: float) -> void:
	
	velocity = Vector2.LEFT * SPEED
	if VOLATILE:
		velocity *= 3.5

	move_and_slide()
	

func _on_collision(collider: Node2D) -> void:
	if collider is Player:
		if !VOLATILE:
			collider.hit(-10)
		else:
			collider.hit(-25)


func _on_scorebox_collision(collider: Node2D) -> void:
	if collider is Player:
		SfXmanager.play_sound("jump", 1.5)
		Global.SCORE += 5 if VOLATILE else 10


func _onscreen() -> void:
	if !has_start:
		has_start = true


func _offscreen() -> void:
	if has_start:
		queue_free()

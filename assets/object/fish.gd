extends CharacterBody2D
class_name  Fish

@export var POINT: int
@export var DAMAGE: float
@export var SPEED: float
@export var DIRECTION: Vector2
enum state { IDLE, PEAKED, HURT, DEAD }
var current_state: state
var has_gravity: bool = true

func _physics_process(delta: float) -> void:
	if has_gravity:
		velocity += get_gravity() * delta
	move_and_slide()

func _process(_delta: float) -> void:
	if not current_state == state.DEAD or not current_state == state.HURT:
		pass

func push(x,y):
	velocity = Vector2(x,y)

extends StaticBody2D

@export var SPEED: float  = 1
@export var TARGET: Node2D
@export var MARGIN: float  = 5:
	set(value):
		MARGIN = value

var locked: bool

var direction: Vector2 = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LeftTrigger.target_position = Vector2.UP
	$RightTrigger.target_position = Vector2.UP


func _physics_process(_delta: float) -> void:
	$LeftTrigger.target_position.y = -MARGIN
	$RightTrigger.target_position.y = -MARGIN
	if !Input.is_action_pressed("run"):
		position.x = lerp(position.x, TARGET.position.x, 0.05)
	else:
		position.x = lerp(position.x, TARGET.position.x, 0.5)
		
	#position.x = clamp(position.x ,450, 625)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if $LeftTrigger.is_colliding():
		direction = direction.lerp(Vector2.LEFT, 0.5)
	elif $RightTrigger.is_colliding():
		direction = direction.lerp(Vector2.RIGHT, 0.5)
	else:
		direction = direction.lerp(Vector2.ZERO, 0.05)
		

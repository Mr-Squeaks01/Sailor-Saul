extends CharacterBody2D
class_name Player

@export var SPEED = 80.0
@export var RUN_SPEED = 160.0
@export var JUMP_VELOCITY = -400.0
@export var MAX_STAMINA = 100.0
enum state { IDLE, WALK, JUMP, SHOOT, HURT, DEAD}
var current_state: state = state.IDLE: 
	set(value):
		current_state = value

static var poisoned: bool
var damage_per_tick: int = -2
var poison_tick: int
var force: float = 0
var stamina: float = 0

func _ready() -> void:
	stamina = MAX_STAMINA

func poison(length, damage):
	poison_tick = length
	poisoned = true
	damage_per_tick = damage
	

func _physics_process(delta: float) -> void:
	# Handle jump.
	#print(poisoned)
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			SfXmanager.play_sound("jump")
			velocity.y = JUMP_VELOCITY
	else:
		if Input.is_action_just_released("jump"):
			velocity.y *= 0.5
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		$AnimatedSprite2D.flip_h = direction -1
		velocity.x = direction * SPEED if !Input.is_action_pressed("run") else direction * RUN_SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, 80.0)
	if Input.is_action_just_pressed("run"):
		SfXmanager.play_sound("throw", 0.1)
	#handles projectiles
	if Input.is_action_just_pressed("throw"):
		throw()
	
	move_and_slide()

func throw():
	var ball = load("res://assets/object/bait.tscn").instantiate()
	ball.position = self.position
	ball.host = self
	if $AnimatedSprite2D.flip_h:
		ball.push(100 * -1, -150 )
	else:
		ball.push(100 * 1, -150)
	add_sibling(ball)
	


func hit(damage :=-1, does_freeze:= true):
	var cal_damage = clamp(damage, -100, 100)
	Global.SCORE += cal_damage
	SfXmanager.play_sound("hit")
	Global.HEALTH += cal_damage
	get_parent().update()
	$AnimatedSprite2D.play("hit")
	if get_tree(): 
		if does_freeze:
			Global.freeze(["Camera", "Timer"], 0.5)
		get_parent().get_node("Camera").shake(10.0, 10.0)
		await Global.freeze_finished
	if Global.HEALTH < 1:
		get_parent().blackout()
		await  get_tree().create_timer(2).timeout
		
		if Global.LIVES > 0:
			Global.HEALTH = 100
			Global.LIVES -= 1
			get_tree().call_deferred("reload_current_scene")
		else:
			get_tree().call_deferred("change_scene_to_file", "res://scenes/game_over.tscn")


func _process(_delta: float) -> void:
	if current_state == state.IDLE:
		$AnimatedSprite2D.play("default")
	if current_state == state.WALK:
		$AnimatedSprite2D.play("walk")
	if current_state == state.JUMP:
		$AnimatedSprite2D.play("jump")
	if current_state == state.SHOOT:
		$AnimatedSprite2D.play("throw")
	_process_states()

func _process_states():
	if current_state != state.HURT:
		if current_state != state.SHOOT:
			if is_on_floor():
				if velocity.x == 0:
					current_state = state.IDLE
				else:
					current_state = state.WALK
			else:
				current_state = state.JUMP
		if Input.is_action_just_pressed("throw"):
			current_state = state.SHOOT
			await get_tree().create_timer(0.5).timeout
			current_state = state.IDLE


func _on_tick() -> void:
	if Player.poisoned and Dustin.onscreen:
		hit(damage_per_tick, false)

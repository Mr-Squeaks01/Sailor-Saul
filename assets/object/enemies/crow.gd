extends CharacterBody2D

var ACTIVE = false
var VOLATILE = false
var paused = false
var onscreen = false

func _ready() -> void:
	pass

func activate():
	$bomb.hide()
	%CrowSprite.play("default")
	$bomb.ACTIVE = false
	$bomb.position = position
	position = Vector2(297.0,438.0)
	ACTIVE = true
	paused = false
	SfXmanager.play_sound("thow")
	await  get_tree().create_timer(randf_range(0.9, 5)).timeout
	paused = true
	$bomb.activate()
func _physics_process(_delta: float) -> void:
	if ACTIVE and !paused:
		if not $bomb.ACTIVE:
			$bomb.position.x = position.x
		velocity.x = 100
	if paused:
		%CrowSprite.play("shout")
		await get_tree().create_timer(0.5).timeout
		%CrowSprite.play("default")
		paused = false
	move_and_slide()


func _onscreen() -> void:
	onscreen = true


func _offscreen() -> void:
	onscreen = false
	$bomb.ACTIVE = false
	if ACTIVE:
		ACTIVE = false

extends Node

var SCORE: int = 0
var WAVE: int = 1
var LIVES: int = 3
var HEALTH: float = 100
var GOAL: int = 1
var COINS: int = 0
var aggression: int = 1

signal freeze_start
signal freeze_finished

func _ready() -> void:
	pass

func freeze(exception:= [], time: float = 1):
	var current = get_tree().current_scene
	if exception.size() > 0:
		for i in current.get_children():
			if i.name in exception:
				i.process_mode = Node.PROCESS_MODE_ALWAYS
			else:
				i.process_mode = Node.PROCESS_MODE_PAUSABLE
	current.get_tree().set_deferred("paused", true)
	freeze_start.emit()
	await get_tree().create_timer(time).timeout
	current.get_tree().set_deferred("paused", false)
	freeze_finished.emit()


func get_current_scene():
	return get_tree().current_scene

func  _process(_delta: float) -> void:
	if get_current_scene() != null and get_current_scene().name == "area":
		get_current_scene().update()
	if get_current_scene() != null and get_current_scene().name == "title_scene":
		WAVE = 1
	aggression = WAVE + 20


func change_value_by(value,amount):
	set(value, get(value) + amount)

func reset():
	SCORE = 0
	COINS = 0
	LIVES = 3
	HEALTH = 100
	GOAL = randi_range(1000, 2000)

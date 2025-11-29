extends Node
class_name ObjectBehavior2D

@export var amp: float
@export var speed: float
@export var enabled: bool

func _ready() -> void:
	if !enabled:
		return

func _process(_delta: float) -> void:
	if !enabled:
		return

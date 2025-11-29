extends Node2D

func _ready() -> void:
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/title_scene.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		get_tree().change_scene_to_file("res://scenes/title_scene.tscn")

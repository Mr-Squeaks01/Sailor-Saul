extends Node2D

func _ready() -> void:
	SfXmanager.play_sound("game_over")
	await get_tree().create_timer(5).timeout
	$AudioStreamPlayer.play()

func end(scene):
	Global.reset()
	$AudioStreamPlayer.stop()
	$CanvasModulate.color = Color.BLACK
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file(scene)

func _on_retry_button_pressed() -> void:
	end("res://scenes/area.tscn")


func _on_menu_button_pressed() -> void:
	end("res://scenes/title_screen.tscn")

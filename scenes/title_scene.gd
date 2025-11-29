extends Node2D


func _process(_delta: float) -> void:
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		$start_game.grab_focus()


func _on_tick_timeout() -> void:
	pass


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	$tick.start()
	$title/WaveBehavior.enabled = true


func _on_start_game_pressed() -> void:
	SfXmanager.play_sound("jump")
	get_tree().change_scene_to_file("res://scenes/level_start.tscn")

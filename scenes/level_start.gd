extends Node2D

class counter:
	var value := 0.0
	var final_value := 0.0
	var speed := 0.0
	var index := 0.0
	var active := false
	var capped := false
	signal has_started
	signal is_paused
	signal has_finished
	func start(min_v, max_v, sec):
		active = true
		value = min_v
		final_value = max_v
		speed = sec
		index = 0.0
		has_started.emit()
	func stop():
		active = false
		is_paused.emit()
	func update():
		if active:
			index += speed
			index = clampf(index, 0.0, 1.0)
			if not capped:
				SfXmanager.play_sound("jump", randf_range(0.4, 1.0))
				value = lerp(value, final_value, index)
			if value == final_value and not capped:
				has_finished.emit()
				capped = true

var level_stat = counter.new()

func _ready() -> void:
	%label.hide()
	%numberLabel.hide()
	await get_tree().create_timer(2).timeout
	SfXmanager.play_sound("power_up")
	%label.show()
	await get_tree().create_timer(2).timeout
	level_stat.start(0, Global.WAVE, 0.01)
	%numberLabel.text = ""
	%numberLabel.show()
	await level_stat.has_finished
	await get_tree().create_timer(2).timeout
	SfXmanager.play_sound("power_up", 1.5)
	$AnimationPlayer.play("outro")
	await $AnimationPlayer.animation_finished
	Global.reset()
	get_tree().change_scene_to_file("res://scenes/area.tscn")


func _process(_delta: float) -> void:
	%numberLabel.text = str("%08d" % level_stat.value)
	level_stat.update()



func _on_tick_timeout() -> void:
	pass

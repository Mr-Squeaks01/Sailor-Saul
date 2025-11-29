extends Node2D
class_name Game
static var just_start: bool
@export var FISH_POOL: Array[PackedScene]
var Diff = {}
var enemy_pool = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.SCORE = 0
	#$crow.activate()
	randomize()
	Diff = {
		"Dustin": randi_range(0, Global.aggression) - 1,
		"Urchin": randi_range(0, Global.aggression),
		"Crow": randi_range(0, Global.aggression) - 1
	}
	for key in Diff.keys():
		for i in Diff[key]:
			enemy_pool.append(key)
		for i in 9 - Global.aggression:
			enemy_pool.append("NONE")
	#print(enemy_pool)
	just_start = true
	await get_tree().create_timer(4).timeout
	$tick.start()

func fish_hit():
	pass


func add_popup(points, pos):
	var display = load("res://assets/object/popup.tscn").instantiate()
	display.popup(points, pos)
	add_child(display)
	


func generate_fish():
	var instance = FISH_POOL[0].instantiate()
	add_child(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func calculate_time():
	var time = $end_timer.time_left
	var cal_time = str(snapped(time / 60, 0.01))
	var minutes = str(cal_time.split(".")[0])
	#var seconds = str("%02d" % )
	var seconds = round(float(str("0.",cal_time.split(".")[1])) * 60)
	var result = str("00", ":", "%02d" % int(minutes),":", "%02d" % int(seconds))
	return result

func update():
	%circle.value = Global.SCORE
	%circle.max_value = Global.GOAL
	%timeLabel.text = str(calculate_time())
	$ship.SPEED = $player.SPEED / 20
	%healthBar.value = Global.HEALTH
	%lifeLabel.text = str("*","%02d" % Global.LIVES)
	%scoreLabel.text = str("%08d" % Global.SCORE)

func _on_border_body_entered(_body: Node2D) -> void:
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	pass

func clear():
	for i in get_children():
		if i.has_meta("EntityType"):
			i.queue_free()

func _on_tick_timeout() -> void:
	var value = enemy_pool.pick_random()
	match value:
		"Urchin":
			spawn_urch()
		"Dustin":
			$dustin.toggle_active()
		"Crow":
			if not $crow.onscreen and not $crow.ACTIVE:
				$crow.activate()
	just_start = false
	if Coin.count < 1:
		spawn_coin()
	

func spawn_urch():
	var urchine: CharacterBody2D = load("res://assets/object/enemies/urchin.tscn").instantiate()
	urchine.position = Vector2(700, 610) 
	add_child(urchine)

func spawn_coin():
	var coin: CharacterBody2D = load("res://assets/object/coin.tscn").instantiate()
	coin.position = Vector2(randf_range(400.0, 600.0) , 400)
	add_child(coin)

func blackout():
	clear()
	$tick.stop()
	modulate = Color.BLACK
	$CanvasLayer.hide()


func _on_end_timer_timeout() -> void:
	if Global.SCORE >= Global.GOAL:
		#Global.freeze([self], 1)
		$CanvasLayer2.show()
		$tick.stop()
		clear()
		await get_tree().create_timer(2).timeout
		Global.WAVE += 1
		get_tree().call_deferred("change_scene_to_file", "res://scenes/level_start.tscn")
	else:
		$player.hit(-1000)

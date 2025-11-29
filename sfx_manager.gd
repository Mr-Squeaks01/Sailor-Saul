extends Node

var path = "res://assets/SFX/"

func _ready() -> void:
	for i in DirAccess.open(path).get_files().size():
		var cur = DirAccess.open(path).get_files()[i]
		if !cur.contains("import"):
			var sound = AudioStreamPlayer.new()
			sound.bus = &"SFX"
			sound.stream = ResourceLoader.load(str(path,cur))
			sound.name = cur.get_slice("/",4).replace(".wav", "")
			add_child(sound)
	#play_sound("walk")

func play_sound(sound, pitch:= 1.0, volume:= 1.0):
	if !has_node(sound):
		print("sound effect not found!")
		return
	get_node(sound).pitch_scale = pitch
	get_node(sound).volume_db = volume
	
	get_node(sound).play()

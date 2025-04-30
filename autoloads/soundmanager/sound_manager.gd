extends Node
class_name SoundManager

@onready var sfx = {
	#"dash": preload("res://assets/sounds/dash.wav"),
	#"hit": preload("res://assets/sounds/hit.wav"),
	#"jump": preload("res://assets/sounds/jump.wav")
}

func play(name: String):
	var player = AudioStreamPlayer.new()
	player.stream = sfx[name]
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)

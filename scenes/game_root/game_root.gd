extends Node

func _ready():
	global.player = $Player
	print("✅ Player jump strength at start:", global.player.jump_component.jump_strength)

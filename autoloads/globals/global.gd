extends Node
class_name Global

var last_checkpoint_scene_path: String = "res://scenes/levels/level_01.tscn"
var last_checkpoint_spawn_name: String = "Start"
var last_checkpoint_grid_position: Vector2i = Vector2i.ZERO

var player: Node2D = null
var player_health: int = 3
var keys_collected: int = 0

var last_checkpoint_grid: Vector2i = Vector2i.ZERO

var last_checkpoint_data: Dictionary = {
	"scene_path": "res://scenes/levels/level_01.tscn",
	"spawn_name": "Start",
	"grid_position": Vector2i(0, 0),
	"level_id": "level_01"
}

func save_checkpoint():
	var config = ConfigFile.new()
	for key in last_checkpoint_data.keys():
		config.set_value("checkpoint", key, last_checkpoint_data[key])
	config.save("user://checkpoint.cfg")

func load_checkpoint():
	var config = ConfigFile.new()
	if config.load("user://checkpoint.cfg") == OK:
		for key in last_checkpoint_data.keys():
			last_checkpoint_data[key] = config.get_value("checkpoint", key, last_checkpoint_data[key])
	else:
		print("⚠️ No checkpoint file found.")

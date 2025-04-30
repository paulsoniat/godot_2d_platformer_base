extends Node
class_name Global

var last_checkpoint_scene_path: String = "res://scenes/levels/level_01.tscn"
var last_checkpoint_spawn_name: String = "Start"

var player: Node2D = null
var player_health: int = 3
var keys_collected: int = 0

var last_checkpoint_grid: Vector2i = Vector2i.ZERO

func save_checkpoint():
	var config = ConfigFile.new()
	config.set_value("checkpoint", "scene_path", last_checkpoint_scene_path)
	config.set_value("checkpoint", "spawn_name", last_checkpoint_spawn_name)
	config.set_value("checkpoint", "grid_x", last_checkpoint_grid.x)
	config.set_value("checkpoint", "grid_y", last_checkpoint_grid.y)
	config.save("user://checkpoint.save")

func load_checkpoint():
	var config = ConfigFile.new()
	if config.load("user://checkpoint.save") == OK:
		last_checkpoint_scene_path = config.get_value("checkpoint", "scene_path", last_checkpoint_scene_path)
		last_checkpoint_spawn_name = config.get_value("checkpoint", "spawn_name", last_checkpoint_spawn_name)
		last_checkpoint_grid = Vector2i(
			config.get_value("checkpoint", "grid_x", 0),
			config.get_value("checkpoint", "grid_y", 0)
		)
	else:
		print("No checkpoint save found.")

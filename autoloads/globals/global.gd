extends Node
class_name Global

var last_checkpoint_scene_path: String = "res://scenes/levels/level_01.tscn"
var last_checkpoint_spawn_name: String = "Start"

var player: Node2D = null
var player_health: int = 3
var keys_collected: int = 0

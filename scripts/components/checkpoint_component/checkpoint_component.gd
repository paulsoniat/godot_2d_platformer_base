extends Area2D
class_name CheckpointComponent

@export var spawn_name: String = ""
@export var level_scene_path: String = ""

@onready var grid_size := Vector2(640, 360)  # Match your world grid size

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		var grid_position = Vector2i(
			floor(global_position.x / grid_size.x),
			floor(global_position.y / grid_size.y)
		)

		global.last_checkpoint_scene_path = level_scene_path
		global.last_checkpoint_spawn_name = spawn_name
		global.last_checkpoint_grid_position = grid_position

		print("✅ Checkpoint set:", level_scene_path, spawn_name, grid_position)

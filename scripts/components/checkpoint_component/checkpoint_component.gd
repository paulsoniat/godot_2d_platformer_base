extends Area2D
class_name CheckpointComponent

@export var spawn_name: String = ""

@onready var grid_size := Vector2(640, 360)  # Match your world grid size

func _ready():
	if spawn_name == "":
		push_warning("⚠️ Checkpoint missing spawn_name! Set it in the Inspector.")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		var grid_position = Vector2i(
			floor(global_position.x / grid_size.x),
			floor(global_position.y / grid_size.y)
		)

		var scene_path = get_parent_scene_path(self)

		global.last_checkpoint_data = {
			"scene_path": scene_path,
			"spawn_name": spawn_name,
			"grid_position": grid_position,
			"level_id": "level_01"  # You can make this dynamic if needed later
		}

		global.save_checkpoint()
		print("✅ Checkpoint set:", global.last_checkpoint_data)

func get_parent_scene_path(node: Node) -> String:
	var current = node
	while current:
		if current.scene_file_path != "" and current != self:
			return current.scene_file_path
		current = current.get_parent()
	return ""

extends Area2D
class_name LevelTransitionComponent

@export var target_scene_path: String
@export var target_spawn_name: String
@export var target_grid_position: Vector2i
@export var level_id: String = ""

signal level_transition_requested(data: Dictionary)

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name != "Player":
		return

	print("🌍 Level transition triggered!")

	var checkpoint_data := {
		"scene_path": target_scene_path,
		"spawn_name": target_spawn_name,
		"grid_position": target_grid_position,
		"level_id": level_id
	}
	print_debug("Tree root name: ", get_tree().get_root().name)
	print_debug("Full tree structure:")
	for child in get_tree().get_root().get_children():
		print_debug(" - ", child.name)

	global.last_checkpoint_data = checkpoint_data
	global.save_checkpoint()

	# Emit signal for modular handling
	level_transition_requested.emit(checkpoint_data)

	# Or fallback to hardcoded if needed
	var game_root = get_tree().get_root().get_node("GameRoot")
	var room_manager = game_root.get_node_or_null("RoomManager")
	if room_manager:
		await room_manager.load_room(target_scene_path, target_spawn_name)
	else:
		push_error("❌ RoomManager not found.")

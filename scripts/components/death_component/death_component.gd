extends Node
class_name DeathComponent

func _ready():
	eventbus.player_died.connect(_on_player_died)

func _on_player_died():
	print("☠️ Player died. Respawning...")

	var game_root := get_tree().get_root().get_node("GameRoot")
	var room_manager := game_root.get_node_or_null("RoomManager")

	if room_manager:
		var checkpoint = global.last_checkpoint_data
		await room_manager.load_room(
			checkpoint["scene_path"],
			checkpoint["spawn_name"]
		)

		# ✅ Snap camera after scene is loaded
		var camera := game_root.get_node_or_null("GameCamera")
		if camera and checkpoint.has("grid_position"):
			camera.snap_to_grid_position(checkpoint["grid_position"])
	else:
		push_error("❌ RoomManager not found inside GameRoot.")

extends Node
class_name DeathComponent

func _ready():
	eventbus.player_died.connect(_on_player_died)

func _on_player_died():
	if global.is_respawning:
		return  # Prevent double-respawn
	global.is_respawning = true
	var room_manager = get_tree().get_root().find_child("RoomManager", true, false)
	var checkpoint = global.last_checkpoint_data
	if room_manager:
		await room_manager.load_room(
			checkpoint["scene_path"],
			checkpoint["spawn_name"]
		)
		global.is_respawning = false  # ✅ allow dying again after respawn
	else:
		push_error("❌ RoomManager not found inside GameRoot.")

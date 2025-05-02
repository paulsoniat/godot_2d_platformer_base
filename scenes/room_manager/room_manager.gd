extends Node
class_name RoomManager

var current_room: Node = null
@onready var room_container := $"../RoomContainer"
@onready var player_scene := preload("res://scenes/player/Player.tscn")

func _ready():
	await load_room(
		global.last_checkpoint_data["scene_path"],
		global.last_checkpoint_data["spawn_name"]
	)
	# In _ready()
	for node in get_tree().get_nodes_in_group("level_transitioners"):
		if node.has_signal("level_transition_requested"):
			node.level_transition_requested.connect(_on_level_transition_requested)
	
func _on_level_transition_requested(data: Dictionary):
	await load_room(data["scene_path"], data["spawn_name"])


func load_room(scene_path: String, spawn_point: String = "") -> void:
	print(scene_path, spawn_point, 'scene spawn on death after checkpoint')
	if current_room:
		room_container.remove_child(current_room)
		current_room.queue_free()
		await get_tree().process_frame

	var level_scene = load(scene_path)
	if not level_scene:
		push_error("❌ Failed to load level: " + scene_path)
		return

	current_room = level_scene.instantiate()
	room_container.add_child(current_room)
	await get_tree().process_frame

	# ✅ Default to "Start" if no spawn_point is set
	var spawn_point_name := spawn_point
	if spawn_point_name == "" and global.last_checkpoint_data.has("spawn_name"):
		spawn_point_name = global.last_checkpoint_data["spawn_name"]
	if spawn_point_name == "":
		spawn_point_name = "Start"

	# ✅ Step 1: Make sure player exists early in the game (e.g. GameRoot.gd assigns it)
	if not global.player or not is_instance_valid(global.player):
		print("❌ global.player is null or invalid! Make sure it's assigned in GameRoot.")
		return

	# ✅ Step 2: Add to RoomContainer if not already
	if global.player.get_parent() != room_container:
		print('player is not in room container')
		if global.player.get_parent():
			print(global.player)
			global.player.get_parent().remove_child(global.player)
			print(global.player)
		room_container.add_child(global.player)

	# ✅ Step 3: Position the player at the spawn
	var spawn = find_spawn_point(current_room, spawn_point_name)
	if spawn:
		global.player.velocity = Vector2.ZERO
		global.player.reset_after_respawn()
		global.player.set_deferred("global_position", spawn.global_position)
	else:
		print("⚠️ Spawn point not found: %s. Using (0,0)." % spawn_point_name)
		global.player.global_position = Vector2.ZERO



func find_spawn_point(parent: Node, name: String) -> Node:
	for child in parent.get_children():
		if child.name == name:
			return child
		if child.has_method("get_children"):
			var found = find_spawn_point(child, name)
			if found:
				return found
	return null

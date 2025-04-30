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



func load_room(scene_path: String, spawn_point: String) -> void:
	if current_room:
		room_container.remove_child(current_room)
		current_room.queue_free()
		await get_tree().process_frame

	var level_scene = load(scene_path)
	if not level_scene:
		push_error("❌ Failed to load level: " + scene_path)
		return

	var new_room = level_scene.instantiate()
	room_container.add_child(new_room)
	await get_tree().process_frame

	current_room = new_room

	# Remove old player if needed
	if global.player and is_instance_valid(global.player):
		global.player.queue_free()

	global.player = player_scene.instantiate()
	room_container.add_child(global.player)

	var spawn = find_spawn_point(new_room, spawn_point)
	if spawn:
		global.player.global_position = spawn.global_position
	else:
		push_error("❌ Spawn point not found: " + spawn_point)

func find_spawn_point(parent: Node, name: String) -> Node:
	for child in parent.get_children():
		if child.name == name:
			return child
		var found = find_spawn_point(child, name)
		if found:
			return found
	return null

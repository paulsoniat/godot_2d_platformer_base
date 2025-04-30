extends Node
class_name RoomManager

var current_room: Node
@onready var room_container := $"../RoomContainer"

func _ready():
	load_room(global.last_checkpoint_scene_path, global.last_checkpoint_spawn_name)

func load_room(scene_path: String, spawn_point: String):
	if current_room:
		room_container.remove_child(current_room)
		current_room.queue_free()

	var scene = load(scene_path).instantiate()
	room_container.add_child(scene)
	current_room = scene

	# Spawn player
	var player_scene = load("res://scenes/player/Player.tscn").instantiate()
	global.player = player_scene
	room_container.add_child(player_scene)

	# Position player at spawn
	var spawn = find_spawn_point(scene, spawn_point)
	if spawn:
		global.player.global_position = spawn.global_position
	else:
		push_error("Spawn point not found: " + spawn_point)

func find_spawn_point(parent: Node, name: String) -> Node:
	for child in parent.get_children():
		if child.name == name:
			return child
		var found = find_spawn_point(child, name)
		if found:
			return found
	return null

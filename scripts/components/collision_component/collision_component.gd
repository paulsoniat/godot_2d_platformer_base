extends Node2D
class_name CollisionComponent

func _physics_process(delta):
	var parent = get_parent()
	if not parent or not parent is CharacterBody2D:
		return

	var collision = parent.move_and_collide(parent.velocity * delta)

	if collision:
		print("✅ COLLISION:", collision)

		# Instead of relying on collider → use world position
		var world_pos = collision.get_position()

		# Try to find a TileMap node in the scene — you can also use groups if needed
		var tilemap = get_tree().get_first_node_in_group("tilemap")
		if not tilemap:
			print("⚠️ No tilemap found in group.")
			return

		# Convert world position to tile coords
		var tile_pos = tilemap.local_to_map(world_pos)
		var tile_data = tilemap.get_cell_tile_data(tile_pos)

		print("Tile @", tile_pos, " → ", tile_data)

		if tile_data:
			var type = tile_data.get_custom_data("type")
			print("Tile type:", type)
			if type == "hazard":
				print("💀 Player hit hazard!")
				eventbus.player_died.emit()

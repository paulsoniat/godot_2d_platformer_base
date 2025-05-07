extends Node2D
class_name CollisionComponent

func _physics_process(delta: float) -> void:
	if global.is_respawning:
		return  # Prevent re-triggering during respawn

	var parent := get_parent()
	if not parent or not parent is CharacterBody2D:
		return

	var collision: KinematicCollision2D = parent.move_and_collide(parent.velocity * delta)
	if collision:
		var world_pos: Vector2 = collision.get_position()

		# ✅ Get TileMapLayer node from group
		var tilemap_layer: TileMapLayer = get_tree().get_first_node_in_group("tilemap")
		if not tilemap_layer:
			print("❌ No TileMapLayer node found in group.")
			return

		# Convert world position to local position relative to the TileMapLayer
		var local_pos: Vector2 = tilemap_layer.to_local(world_pos)
		var tile_pos: Vector2i = tilemap_layer.local_to_map(local_pos)

		var tile_source_id: int = tilemap_layer.get_cell_source_id(tile_pos)

		if tile_source_id == -1:
			return

		var tile_data: TileData = tilemap_layer.get_cell_tile_data(tile_pos)

		if tile_data:
			var type: String = tile_data.get_custom_data("type")
			print("🔎 Tile type:", type)
			if type == "hazard":
				eventbus.player_died.emit()
		else:
			print("❌ Tile exists but no TileData found.")

extends Node2D
class_name CollisionComponent

func _physics_process(delta):
	var parent = get_parent()
	if not parent or not parent is CharacterBody2D:
		return

	var collision = parent.move_and_collide(parent.velocity * delta)
	if collision and collision.get_collider() is TileMap:
		var tilemap := collision.get_collider() as TileMap
		var tile_pos = tilemap.local_to_map(collision.get_position())
		var tile_data = tilemap.get_cell_tile_data(0, tile_pos)  # use correct layer if needed

		if tile_data:
			var type = tile_data.get_custom_data("type")
			if type == "hazard":
				print('player hit hazard')
				eventbus.player_died.emit()

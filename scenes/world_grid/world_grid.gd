extends Node2D
class_name WorldGrid

@export var cell_size: Vector2 = Vector2(640, 360)
@export var draw_debug_grid: bool = true

func _draw():
	if not draw_debug_grid:
		return

	var rect = Rect2(Vector2.ZERO, get_viewport_rect().size * 2) # Bigger to cover view
	for x in range(0, int(rect.size.x), int(cell_size.x)):
		draw_line(Vector2(x, 0), Vector2(x, rect.size.y), Color(1, 0, 0, 0.4))
	for y in range(0, int(rect.size.y), int(cell_size.y)):
		draw_line(Vector2(0, y), Vector2(rect.size.x, y), Color(1, 0, 0, 0.4))

func _ready():
	queue_redraw()

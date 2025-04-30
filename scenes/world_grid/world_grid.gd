extends Node2D
class_name WorldGrid

@export var cell_size: Vector2 = Vector2(640, 360)
@export var draw_debug_grid: bool = true
@onready var camera := get_viewport().get_camera_2d()

func _draw():
	if not draw_debug_grid or camera == null:
		return

	var offset = camera.global_position - (get_viewport_rect().size / 2)
	var rect = Rect2(offset.floor(), get_viewport_rect().size * 2)

	for x in range(int(rect.position.x), int(rect.position.x + rect.size.x), int(cell_size.x)):
		draw_line(Vector2(x, rect.position.y), Vector2(x, rect.position.y + rect.size.y), Color(1, 0, 0, 0.4))
	for y in range(int(rect.position.y), int(rect.position.y + rect.size.y), int(cell_size.y)):
		draw_line(Vector2(rect.position.x, y), Vector2(rect.position.x + rect.size.x, y), Color(1, 0, 0, 0.4))

func _editor_draw():
	_draw()

func _process(delta):
	queue_redraw()

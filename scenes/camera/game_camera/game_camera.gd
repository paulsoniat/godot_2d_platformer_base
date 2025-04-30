extends Camera2D
class_name GameCamera

@export var grid_cell_size: Vector2 = Vector2(640, 360)
@export var smoothing_speed: float = 5.0

@onready var player = get_parent().get_node("Player")
var current_grid_position: Vector2
var target_position: Vector2

func _ready():
	position_smoothing_enabled = false
	await get_tree().process_frame
	snap_camera()

func _physics_process(delta):
	update_camera(delta)

func snap_camera():
	if not player:
		return
	current_grid_position = (player.global_position / grid_cell_size).floor()
	target_position = current_grid_position * grid_cell_size + grid_cell_size / 2
	global_position = target_position.round()

func update_camera(delta: float):
	if not player:
		return

	var new_grid_position = (player.global_position / grid_cell_size).floor()
	if new_grid_position != current_grid_position:
		current_grid_position = new_grid_position
		target_position = current_grid_position * grid_cell_size + grid_cell_size / 2

	var smoothing_factor = clamp(smoothing_speed * delta, 0, 1)
	global_position = global_position.lerp(target_position, smoothing_factor).round()

func snap_to_grid_position(grid_pos: Vector2i):
	var grid = Vector2(grid_pos.x, grid_pos.y)  # Convert to Vector2
	global_position = grid * grid_cell_size + grid_cell_size / 2

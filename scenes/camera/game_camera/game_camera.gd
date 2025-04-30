extends Camera2D
class_name GameCamera

@export var grid_cell_size: Vector2 = Vector2(320, 180)
@export var smoothing_speed: float = 5.0

@onready var player = get_parent().get_node("Player")

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
	var player_pos = player.global_position
	target_position = (player_pos / grid_cell_size).floor() * grid_cell_size + grid_cell_size / 2
	global_position = target_position

func update_camera(delta):
	if not player:
		return
	var player_pos = player.global_position
	var desired_center = (player_pos / grid_cell_size).floor() * grid_cell_size + grid_cell_size / 2

	if desired_center != target_position:
		target_position = desired_center

	var smoothing_factor = clamp(smoothing_speed * delta, 0, 1)
	global_position = global_position.lerp(target_position, smoothing_factor)

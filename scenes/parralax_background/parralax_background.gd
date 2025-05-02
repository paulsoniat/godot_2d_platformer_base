extends ParallaxBackground
class_name ParallaxController

@export var textures: Array[Texture2D] = []  # Background images (far → close)
@export var motion_scales: Array[Vector2] = [
	Vector2(0.1, 0.1),
	Vector2(0.3, 0.3),
	Vector2(0.6, 0.6),
	Vector2(0.8, 0.8)
]
@export var camera_path: NodePath = ^"/root/GameRoot/GameCamera"
@export var grid_size: Vector2 = Vector2(640, 360)

var camera: Camera2D
var layer_nodes: Array[ParallaxLayer] = []

func _ready() -> void:
	# Setup camera
	camera = get_node_or_null(camera_path)
	if not camera:
		push_error("❌ ParallaxController: Camera not found at: " + str(camera_path))
		return

	# Disable Godot's auto-follow — we do manual syncing
	set_follow_viewport(false)
	layer_nodes = [
		$Layer_Far,
		$Layer_Mid,
		$Layer_Close,
		$Layer_Foreground
	]

	for i in range(min(layer_nodes.size(), textures.size(), motion_scales.size())):
		var layer = layer_nodes[i]
		layer.motion_scale = motion_scales[i]
		var sprite = layer.get_node("Sprite2D") as Sprite2D
		sprite.texture = textures[i]
		sprite.position = Vector2.ZERO  # Center it (optional)

func _process(delta: float) -> void:
	if not camera:
		return

	var cam_pos = camera.global_position
	var snapped_pos = (cam_pos / grid_size).floor() * grid_size
	scroll_offset = snapped_pos

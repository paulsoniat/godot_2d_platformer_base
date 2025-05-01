extends Node
class_name JumpComponent

signal jump_triggered

@export var jump_strength: float = 500
@export var coyote_time: float = 0.25
@export var jump_buffer_time: float = 0.1

var coyote_timer := 0.0
var jump_buffer_timer := 0.0

func _physics_process(delta):
	coyote_timer -= delta
	jump_buffer_timer -= delta

func update_state(is_on_floor: bool):
	if is_on_floor:
		coyote_timer = coyote_time

func register_jump_input():
	jump_buffer_timer = jump_buffer_time

func try_jump(parent: CharacterBody2D, velocity: Vector2) -> Vector2:
	if coyote_timer > 0 and jump_buffer_timer > 0:
		velocity.y = -jump_strength
		coyote_timer = 0
		jump_buffer_timer = 0
		emit_signal("jump_triggered")
	return velocity

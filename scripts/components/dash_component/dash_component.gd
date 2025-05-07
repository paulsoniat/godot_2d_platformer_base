extends Node
class_name DashComponent

signal dash_started
signal dash_finished

@export var dash_speed := 300.0
@export var dash_duration := 0.2
@export var dash_cooldown := 0.5

var _is_dashing := false
var _dash_timer := 0.0
var _cooldown_timer := 0.0
var _dash_direction := Vector2.ZERO

func process_dash_logic(delta: float, player: CharacterBody2D, input_vector: Vector2):
	if _cooldown_timer > 0:
		_cooldown_timer -= delta

	if _is_dashing:
		_dash_timer -= delta
		if _dash_timer <= 0:
			_end_dash(player)
		else:
			player.velocity = _dash_direction * dash_speed

func try_start_dash(input_vector: Vector2):
	if _cooldown_timer > 0 or _is_dashing:
		return false
	if input_vector == Vector2.ZERO:
		_dash_direction = Vector2.RIGHT  # default fallback
	else:
		_dash_direction = input_vector.normalized()

	_is_dashing = true
	_dash_timer = dash_duration
	_cooldown_timer = dash_cooldown
	emit_signal("dash_started")
	return true

func _end_dash(player: CharacterBody2D):
	_is_dashing = false
	player.velocity = Vector2.ZERO
	emit_signal("dash_finished")

func is_dashing() -> bool:
	return _is_dashing

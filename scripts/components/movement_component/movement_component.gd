extends Node
class_name MovementComponent

@export var move_speed: float = 200.0
@export var acceleration: float = 1500.0
@export var friction: float = 1200.0

func get_horizontal_velocity(input_x: float, current_velocity_x: float, delta: float) -> float:
	if input_x != 0:
		return move_toward(current_velocity_x, input_x * move_speed, acceleration * delta)
	else:
		return move_toward(current_velocity_x, 0, friction * delta)

extends Node
class_name MovementComponent

@export var move_speed: float = 200.0
@export var acceleration: float = 1500.0
@export var friction: float = 1200.0

func get_speed() -> float:
	return move_speed

extends Node
class_name GravityComponent

@export var gravity := 1200.0  # Pixels per second squared
@export var terminal_velocity := 1500.0

func apply_gravity(velocity: Vector2, delta: float) -> Vector2:
	velocity.y += gravity * delta
	if velocity.y > terminal_velocity:
		velocity.y = terminal_velocity
	return velocity

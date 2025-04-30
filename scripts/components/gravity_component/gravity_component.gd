extends Node
class_name GravityComponent

@export var gravity := 1200.0
@export var max_fall_speed := 1500.0
@export var jump_cut_multiplier := 0.5

func apply_gravity(velocity: Vector2, delta: float) -> Vector2:
	velocity.y += gravity * delta
	if velocity.y > max_fall_speed:
		velocity.y = max_fall_speed

	# Optional: jump cut (for snappy jump end)
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= jump_cut_multiplier
	return velocity

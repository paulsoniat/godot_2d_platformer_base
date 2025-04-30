extends Node
class_name JumpComponent

@export var jump_strength: float = 450.0

func try_jump(parent: CharacterBody2D, velocity: Vector2) -> Vector2:
	if parent.is_on_floor():
		velocity.y = -jump_strength
	return velocity

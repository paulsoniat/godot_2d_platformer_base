extends Node
class_name AnimationComponent

@onready var animated_sprite: AnimatedSprite2D = get_parent().get_node_or_null("AnimatedSprite2D")

func _ready():
	if not animated_sprite:
		push_error("❌ AnimatedSprite2D not assigned to AnimationComponent.")

# Called from Player or connected to InputComponent
func update_animation(input_vector: Vector2, is_on_floor: bool):
	if not is_on_floor:
		animated_sprite.play("jump")
	elif input_vector.x > 0:
		animated_sprite.play("walk_right")
	elif input_vector.x < 0:
		animated_sprite.play("walk_left")
	else:
		animated_sprite.play("idle")

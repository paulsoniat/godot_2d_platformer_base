extends Node
class_name InputComponent

signal jump_pressed
signal dash_pressed
signal attack_pressed

var input_vector := Vector2.ZERO

func process_input():
	input_vector.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))

	if Input.is_action_just_pressed("jump"):
		emit_signal("jump_pressed")
	if Input.is_action_just_pressed("dash"):
		emit_signal("dash_pressed")
	if Input.is_action_just_pressed("attack"):
		emit_signal("attack_pressed")

extends Node
class_name InputComponent

var input_vector := Vector2.ZERO
var jump_pressed := false
var dash_pressed := false
var attack_pressed := false

func process_input():
	input_vector = Vector2.ZERO
	input_vector.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))

	jump_pressed = Input.is_action_just_pressed("jump")
	dash_pressed = Input.is_action_just_pressed("dash")
	attack_pressed = Input.is_action_just_pressed("attack")

extends CharacterBody2D
class_name Player

@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var jump_component: JumpComponent
@export var attack_component: AttackComponent
@export var wall_component: WallComponent
@export var animation_component: AnimationComponent
@export var audio_component: AudioComponent
@export var health_component: HealthComponent
@export var collision_component: CollisionComponent
@export var gravity_component: GravityComponent

func _physics_process(delta):
	input_component.process_input()

	# Apply jump
	if input_component.jump_pressed:
		velocity = jump_component.try_jump(self, velocity)

	# Apply gravity
	velocity = gravity_component.apply_gravity(velocity, delta)

	# Apply horizontal movement
	var move_x = input_component.input_vector.x
	velocity.x = move_x * movement_component.get_speed()

	# Move using built-in velocity
	move_and_slide()

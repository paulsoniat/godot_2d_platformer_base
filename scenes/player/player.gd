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

func _ready():
	# Connect jump input signal to buffer handler
	input_component.jump_pressed.connect(jump_component.register_jump_input)
	# Optional: React to a jump event
	jump_component.jump_triggered.connect(_on_jump)

func _physics_process(delta):
	input_component.process_input()

	# Update coyote time based on grounded state
	jump_component.update_state(is_on_floor())
	jump_component._physics_process(delta)

	velocity = jump_component.try_jump(self, velocity)
	velocity = gravity_component.apply_gravity(velocity, delta)
	velocity.x = movement_component.get_horizontal_velocity(input_component.input_vector.x, velocity.x, delta)

	# Move player
	move_and_slide()

func _on_jump():
	print('jump')
	#animation_component.play_jump()
	#audio_component.play_jump_sound()

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
@export var death_component: DeathComponent
@export var dash_component: DashComponent

func _ready():
	# Connect jump input signal to buffer handler
	input_component.jump_pressed.connect(jump_component.register_jump_input)
	# Optional: React to a jump event
	jump_component.jump_triggered.connect(_on_jump)
	#Dash connection
	input_component.dash_pressed.connect(_on_dash_pressed)
	dash_component.dash_started.connect(_on_dash_started)
	dash_component.dash_finished.connect(_on_dash_finished)



func _physics_process(delta):
	input_component.process_input()
	animation_component.update_animation(input_component.input_vector, is_on_floor())

	jump_component.update_state(is_on_floor())
	jump_component._physics_process(delta)

	dash_component.process_dash_logic(delta, self, input_component.input_vector)
	if dash_component.is_dashing():
		dash_component.process_dash_logic(delta, self, input_component.input_vector)
	else:
		# Handle movement and jump only if not dashing
		velocity = jump_component.try_jump(self, velocity)
		velocity = gravity_component.apply_gravity(velocity, delta)
		velocity.x = movement_component.get_horizontal_velocity(input_component.input_vector.x, velocity.x, delta)

	move_and_slide()

func _on_jump():
	print('jump')
	#animation_component.play_jump()
	#audio_component.play_jump_sound()
	
	
func reset_after_respawn():
	print("🔄 Resetting player after respawn...")

	# Basic velocity + position safety
	velocity = Vector2.ZERO
	#jump_component.jumps_left = jump_component.max_jumps
	jump_component.coyote_timer = 0.0
	jump_component.jump_buffer_timer = 0.0
	#jump_component.has_jumped = false
	#jump_component.can_jump = true

	## Wall / dash logic reset (if applicable)
	#if wall_component:
		#wall_component.reset()
	#if attack_component:
		#attack_component.reset()
	#if animation_component:
		#animation_component.reset()
	#if audio_component:
		#audio_component.reset()
	#if gravity_component:
		#gravity_component.reset()
	#if collision_component:
		#collision_component.reset()
	#if health_component:
		#health_component.reset()

	# Clear input flags
	input_component.input_vector = Vector2.ZERO

	# Optional: re-enable control logic or flags
	set_physics_process(true)
	set_process(true)

	print("✅ Player reset complete.")
	
func _on_dash_pressed():
	dash_component.try_start_dash(input_component.input_vector)

func _on_dash_started():
	animation_component.play_dash()
	# Optional: Hide sprite, disable collisions, etc.
	$CollisionShape2D.disabled = true
	modulate.a = 0.5  # semi-invisible
	health_component.set_invulnerable(true)

func _on_dash_finished():
	$CollisionShape2D.disabled = false
	modulate.a = 1.0
	health_component.set_invulnerable(false)

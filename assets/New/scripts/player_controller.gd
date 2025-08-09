extends CharacterBody3D

@export var jump_velocity = 4.5
@export var speed = 1.0
@export var acceleration = 0.5
@export var friction = 0.2
@export var mouse_sensitivity = 0.1
@export var sprint_speed = 2.0
@export var bullet: PackedScene

@onready var camera = $head/Camera3D
@onready var head = $head
@onready var raycast: RayCast3D = $head/RayCast3D
@onready var shoot_point: Node3D = $head/shoot_point

var yaw_input = 0.0
var pitch_input = 0.0
var is_player_sprinting = false
var main_health: float = 100.0

func _enter_tree() -> void:
	Global.player = self
	Global.player_health = main_health

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func camera_controller ():
	head.rotate_x(pitch_input)
	head.rotation.x = clamp(head.rotation.x,-1.3,1.5)
	rotate_object_local(Vector3.UP, yaw_input)
	pitch_input = 0
	yaw_input = 0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pewpew"):
		shooting()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += Vector3(0,-9.82,0) * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	if Input.is_action_pressed("sprint"):
		is_player_sprinting = true
	else:
		is_player_sprinting = false
	# Handles camera and head rotation
	camera_controller()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Forwards", "Backwards")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and is_player_sprinting == false:
		velocity.x = lerp(velocity.x,direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration)
	elif direction and is_player_sprinting:
		velocity.x = lerp(velocity.x,direction.x * sprint_speed, acceleration)
		velocity.z = lerp(velocity.z, direction.z * sprint_speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
		velocity.z = lerp(velocity.z, 0.0, friction)

	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			yaw_input = - event.screen_relative.x * mouse_sensitivity 
			pitch_input = - event.screen_relative.y * mouse_sensitivity

func shooting():
	pass
	
	#var collider = raycast.get_collider()
	#if raycast.is_colliding() and collider.is_in_group("Enemy"):
		#collider.get_parent().take_damage()
	#else: print("null")

func take_damage(taken_damage) -> void:
	Global.player_health -= taken_damage

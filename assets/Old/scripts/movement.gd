extends CharacterBody3D

const SPEED = 8.0
const JUMP_VELOCITY = 7.5
const MAX_VELOCITY = 10.0

var acceleration := 1.3
var yaw_input := 0.0
var pitch_input := 0.0

@export var mouse_sensitivity := 0.03
@export var arm_shake_sens := 0

@onready var camera_pivot = $"Camera pivot"
@onready var subviewport_cam = %"viewmodel_cam"
@onready var camera = $"Camera pivot/Camera3D"
@onready var arm: Node3D = $"Camera pivot/Camera3D/arms"

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	subviewport_cam.set_global_transform(camera.get_global_transform())
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += Vector3(0,-15,0) * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Handels the change in pitch on the camera
	camera_pivot.rotate_x(pitch_input)
	camera_pivot.rotation.x = clamp(camera_pivot.rotation.x,-1.2, 1)
	rotate_object_local(Vector3.UP, yaw_input)
	yaw_input = 0
	pitch_input = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Forwards", "Backwards")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if is_on_floor():
			$"Camera pivot/Camera3D/AnimationPlayer".play("arm_sway")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			yaw_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity

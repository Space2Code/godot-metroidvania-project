extends Node3D

const SPEED: float = 20.0

@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var raycast: RayCast3D = $RayCast3D
@onready var particles: GPUParticles3D = $GPUParticles3D

@export var bullet_air_time: float = 10.0

var amount_of_damage: float
var bullet_timer: Timer = Timer.new()

func _ready() -> void:
	add_child(bullet_timer)
	bullet_timer.one_shot = true
	bullet_timer.autostart = false
	bullet_timer.timeout.connect(_timer_timeout)
	bullet_timer.start(bullet_air_time)

func _process(delta: float) -> void:
	position += transform.basis * Vector3(0,0,SPEED) * delta
	
	if raycast.is_colliding() and raycast.get_collider().is_in_group("Player"):
		amount_of_damage = randf_range(8,13)
		raycast.get_collider().take_damage(amount_of_damage)
	elif raycast.is_colliding() and raycast.get_collider().is_in_group("Map"):
		mesh.visible = true
		particles.emitting = true
		queue_free()

func _timer_timeout():
	queue_free()

extends Node3D

@onready var health_bar_ui: ProgressBar = $"SubViewport/Health UI/Health"
@onready var health_bar_sprite: Sprite3D = $"Display Health bar"
@onready var enemy_body: RigidBody3D = $RigidBody3D

@export var bullet_prefab: PackedScene
var bullet_spawn_time: float 

var enemy_health: float = 100.0
var is_player_detected: bool = false
var timer: Timer = Timer.new()

func _ready() -> void:
	bullet_spawn_time = randf_range(1.0,1.6)
	add_child(timer)
	timer.timeout.connect(_timer_timeout)

func _process(delta: float) -> void:
	health_bar_follow_player()
	look_at_player()
	
	if timer.is_stopped():
		timer.start(bullet_spawn_time)
	
func player_detected():
	pass
	
func look_at_player():
	var relative_position_player = -(enemy_body.global_position - Global.player.global_position)
	var angle_to_player = atan2(relative_position_player.x, relative_position_player.z)
	enemy_body.rotation.y = angle_to_player

func on_death():
	queue_free()

func take_damage() -> void:
	enemy_health -= 10.0
	health_bar_ui.value = enemy_health
	if enemy_health <= 0:
		on_death()

func health_bar_follow_player() -> void:
	var healthbar_relative_position = -(health_bar_sprite.global_position - Global.player.global_position)
	var angle_to_player = atan2(healthbar_relative_position.x,healthbar_relative_position.z)
	health_bar_sprite.rotation.y = angle_to_player
	health_bar_sprite.global_position.y = enemy_body.global_position.y + 2
	
func shooting() -> void:
	var bullet = bullet_prefab.instantiate()
	bullet_spawn_time = randf_range(1.0,1.6)
	bullet.position = enemy_body.global_position
	bullet.transform.basis = enemy_body.transform.basis
	get_tree().root.add_child(bullet)
	timer.start(bullet_spawn_time)

func _timer_timeout():
	if Global.is_ai_shooting_enabled:
		shooting()

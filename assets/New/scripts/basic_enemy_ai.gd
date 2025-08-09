extends Node3D

const RANDOM_ENEMY_STATES = [Enemy_states.IDLE, Enemy_states.WANDER]

enum Enemy_states {
	IDLE,
	WANDER,
	PERSUING,
	RETREAT } 

@onready var health_bar_ui: ProgressBar = $"SubViewport/Health UI/Health"
@onready var health_bar_sprite: Sprite3D = $"Display Health bar"
@onready var enemy_body: CharacterBody3D = $CharacterBody3D
@onready var wander_controller = $wander_controller
@onready var detection_area = $CharacterBody3D/player_detction_area
#@onready var player_detection_raycast = 

@export var bullet_prefab: PackedScene

var bullet_spawn_time: float 
var enemy_health: float = 100.0
var is_player_detected: bool = false
var timer: Timer = Timer.new()
var enemy_state: Enemy_states = Enemy_states.IDLE
var walk_speed: float = 4.0
var accelration: float = 20.0
var friction: float = 25.0

func _ready() -> void:
	bullet_spawn_time = randf_range(1.0,1.6)
	add_child(timer)
	timer.timeout.connect(_timer_timeout)

func _process(delta: float) -> void:
	health_bar_follow_player()
	
	if timer.is_stopped():
		timer.start(bullet_spawn_time)
	
func _physics_process(delta: float) -> void:
	var space_state = get_world_3d().direct_space_state
	
	match enemy_state:
		Enemy_states.IDLE:
			enemy_body.velocity = enemy_body.velocity.move_toward(Vector3.ZERO, friction * delta)
			
			if wander_controller.get_time_left() == 0:
				enemy_state = grab_random_state(RANDOM_ENEMY_STATES)
				wander_controller.start_timer(randi_range(1,4))
				
		Enemy_states.WANDER:
			if wander_controller.get_time_left() == 0:
				enemy_state = grab_random_state(RANDOM_ENEMY_STATES)
				wander_controller.start_timer(randi_range(1,4))
			
			var relative_to_target = -(enemy_body.global_position - wander_controller.target_position)
			var angle_to_target = atan2(relative_to_target.x, relative_to_target.z)
			var rotation_tween = get_tree().create_tween()
			rotation_tween.tween_property(enemy_body,"rotation",Vector3(0,angle_to_target,0),0.3)
			
			var direction = enemy_body.global_position.direction_to(wander_controller.target_position)
			enemy_body.velocity = enemy_body.velocity.move_toward(direction * walk_speed, accelration * delta)
			
			if enemy_body.global_position.distance_to(wander_controller.target_position) < walk_speed * delta:
				enemy_state = grab_random_state(RANDOM_ENEMY_STATES)
				wander_controller.start_timer(randi_range(1,4))
			
		Enemy_states.PERSUING:
			pass
			
		Enemy_states.RETREAT:
			pass
		
	enemy_body.move_and_slide()
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
	health_bar_sprite.global_position = enemy_body.global_position
	health_bar_sprite.global_position.y = enemy_body.global_position.y + 1
	
func shooting() -> void:
	var bullet = bullet_prefab.instantiate()
	bullet_spawn_time = randf_range(1.0,1.6)
	bullet.position = enemy_body.global_position
	bullet.transform.basis = enemy_body.transform.basis
	bullet.target_group = "Player"
	get_tree().root.add_child(bullet)
	timer.start(bullet_spawn_time)

func _timer_timeout():
	if Global.is_ai_shooting_enabled:
		shooting()
		
func grab_random_state(state_list: Array):
	return state_list.pick_random()

func _on_player_detction_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		pass

extends Node3D

@onready var start_position = self.global_position
@onready var target_position = self.global_position
@onready var timer: Timer = $Timer

@export var walking_range: int = 20

func update_target_position() -> void:
	var target_vector = Vector3(randf_range(-walking_range, walking_range),0,randf_range(-walking_range,walking_range))
	target_position = start_position + target_vector
	
func get_time_left():
	return timer.time_left

func start_timer(duration) -> void:
	timer.start(duration)

func _on_timer_timeout() -> void:
	update_target_position()

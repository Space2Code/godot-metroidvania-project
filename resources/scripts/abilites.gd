extends Node3D

@onready var raycast: RayCast3D = %RayCast3D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("special_boom") and GameManager.is_hotpotato_unlocked:
		destroyable_wall()

func destroyable_wall():
	if raycast.is_colliding() and raycast.get_collider().is_in_group("kill_wall"):
		raycast.get_collider().get_parent().queue_free()
		

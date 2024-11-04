extends Node

@export var damage = 20

@onready var camera = get_viewport().get_camera_3d()
@onready var raycast: RayCast3D = %RayCast3D

func _input(event: InputEvent) -> void:
	if event as InputEventMouseButton:
		if event.is_action_pressed("pewpew"):
			raycasting()
			
func raycasting():
	if raycast.is_colliding() and raycast.get_collider().has_node("Entity"):
		raycast.get_collider().get_node("Entity").damage_entity(5)

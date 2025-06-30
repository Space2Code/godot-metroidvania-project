extends Node3D

@onready var raycast: RayCast3D = %RayCast3D
@export var carrot_bomb_scene: PackedScene
@onready var emit_point: Node3D = %emit_point
@export var player: CharacterBody3D

@export var force := 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("special_boom") and GameManager.is_carrot_bomb_unlocked:
		_carrot_bomb()
	
	if event.is_action_pressed("teleport") and GameManager.is_teleport_bread_unlocked:
		_teleport_bread()

# This magic carrot will destroy some weak structures for some map progression
func _carrot_bomb():
		var bomb:Node3D = carrot_bomb_scene.instantiate()
		bomb.transform = emit_point.global_transform
		bomb.look_at_from_position(emit_point.global_position,Vector3.UP)
		bomb.get_child(0).apply_central_impulse(-emit_point.global_transform.basis.z*force)
		get_tree().root.add_child(bomb)

# Uses the magic bread to teleport to specific nodes around the map.
# That will take the player to new locations to progress the map
func _teleport_bread():
	if raycast.is_colliding() and raycast.get_collider().is_in_group("teleport_node"):
		player.position = raycast.get_collider().global_position
		player.position.y += 2

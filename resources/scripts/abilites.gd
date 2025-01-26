extends Node3D

@onready var raycast: RayCast3D = %RayCast3D
@export var carrot_bomb_scene: PackedScene
@onready var emit_point: Node3D = %emit_point

@export var force := 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("special_boom") and GameManager.is_carrot_bomb_unlocked:
		var bomb:Node3D = carrot_bomb_scene.instantiate()
		bomb.transform = emit_point.global_transform
		bomb.look_at_from_position(emit_point.global_position,Vector3.UP)
		bomb.get_child(0).apply_central_impulse(-emit_point.global_transform.basis.z*force)
		get_tree().root.add_child(bomb)

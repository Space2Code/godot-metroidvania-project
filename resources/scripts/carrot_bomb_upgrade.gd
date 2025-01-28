extends Node3D

func _on_area_3d_area_entered(area: Area3D) -> void:
	GameManager.is_carrot_bomb_unlocked = true
	queue_free()

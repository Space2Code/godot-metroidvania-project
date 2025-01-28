extends Node3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("destruct"):
		queue_free()
	elif body.is_in_group("kill_wall"):
		body.get_parent().queue_free()
		queue_free()

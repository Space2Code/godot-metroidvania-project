extends Node3D

var rot := 0.0

func _on_area_3d_area_entered(area: Area3D) -> void:
	print("Ping")
	get_parent().queue_free()

func _physics_process(delta: float) -> void:
	rot += 0.05
	get_parent().rotate_y(rot)
	rot = 0

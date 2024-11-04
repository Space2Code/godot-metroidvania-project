extends Node3D

var rotate_weee := 0.0

func _on_area_3d_area_entered(area: Area3D) -> void:
	if get_parent().is_in_group("carrot"):
		GameManager.carrots += 1
		print(GameManager.carrots)
		if GameManager.carrots <= 2:
			GameManager.is_hotpotato_unlocked = true
		get_parent().queue_free()
	else:
		get_parent().queue_free()

func _physics_process(delta: float) -> void:
	rotate_weee += 0.05
	get_parent().rotate_y(rotate_weee)
	rotate_weee = 0

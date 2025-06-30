extends Area3D

@onready var spawnpoint: Marker3D = get_parent().get_node("Spawnpoint")

func _on_area_entered(area: Area3D) -> void:
	area.get_parent().global_position = spawnpoint.global_position
	print(area.get("name"))
		

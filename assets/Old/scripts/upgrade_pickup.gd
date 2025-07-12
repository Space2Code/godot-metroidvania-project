extends Node3D

enum abillites {BREAD, CARROT}
@export var type: abillites
@onready var item_gui: Control

@export_enum("Red", "Blue", "Green", "Orange") var colors

func _on_area_3d_area_entered(area: Area3D) -> void:
	if type == 1:
		GameManager.is_carrot_bomb_unlocked = true
		#item_gui._name_items("Carrot bomb", "#fc9003", "You can destory weak structrucers by pressing G")
		queue_free()
	elif type == 0:
		GameManager.is_teleport_bread_unlocked = true
		queue_free()

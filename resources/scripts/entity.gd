extends Node

@export var health := 20.0
@onready var healthbar = get_parent().get_node("Sprite3D/SubViewport/ProgressBar")

func damage_entity(dmg):
	health -= dmg
	if health > 0:
		healthbar.value = health
	else:
		get_parent().get_parent().queue_free()

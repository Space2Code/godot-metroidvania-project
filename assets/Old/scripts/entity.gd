extends Node

@export var health := 20.0
@onready var healthbar = get_parent().get_node("Sprite3D/SubViewport/ProgressBar")

func damage_entity(dmg):
	health -= dmg
	if health > 0:
		healthbar.value = health
	else:
		if get_parent().is_in_group("Enemy"):
			var death_inst = load("res://modules/gameplay/death_effect.tscn").instantiate()
			healthbar.value = 0
			get_parent().get_parent().add_child(death_inst)
			death_inst.global_position = get_parent().global_position
			get_parent().queue_free()

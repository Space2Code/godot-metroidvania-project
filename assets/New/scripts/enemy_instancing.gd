extends Node3D

@export var amount_of_enemies: int = 5
@export var basic_enemy_scene: PackedScene

@onready var spawn_area: CollisionShape3D = $Area3D/CollisionShape3D

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	spawn_enemies()
	
func spawn_enemies() -> void:
	for i in range(amount_of_enemies):
		var random_cords: Vector3 = Vector3(rng.randf_range(-10.0,10.0),1.0,rng.randf())
		var goon = basic_enemy_scene.instantiate()
		goon.position = random_cords
		add_child(goon)

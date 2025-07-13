extends Node3D

#@onready var player: 
@onready var health_bar_ui: ProgressBar = $"SubViewport/Health UI/Health"
@onready var health_bar_sprite: Sprite3D = $"Display Health bar"

var player_pos: float
var enemy_health: float = 100.0

func _process(delta: float) -> void:
	health_bar_follow_player()

func player_detected():
	pass
	
func look_at_player():
	pass

func on_death():
	queue_free()

func damage():
	enemy_health -= 10.0
	health_bar_ui.value = enemy_health
	if enemy_health <= 0:
		on_death()

func health_bar_follow_player():
	health_bar_sprite.rotation = Global.player.rotation

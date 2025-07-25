extends Control

@onready var health_bar: ProgressBar = $HBoxContainer/VBoxContainer/ProgressBar
@onready var debug_menu: MarginContainer = $HBoxContainer/VBoxContainer/DebugMenuMargin

var is_debug_on: bool = false

func _ready() -> void:
	health_bar.value = Global.player_health
	debug_menu.visible = is_debug_on

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_menu"):
		is_debug_on = not is_debug_on
		debug_menu.visible = is_debug_on
	
	if health_bar.value <= 0.0: 
		Global.is_player_health_zero = true
	else: 	health_bar.value = Global.player_health
		

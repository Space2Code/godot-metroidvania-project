extends Control

@onready var pause_menu: Control = get_node("/root/main/Main menu/Pause") 
@onready var options_menu: Control = get_node("/root/main/Main menu/Options")
@onready var resolution_menu: MenuButton = $Options/Panel/MarginContainer/VBoxContainer/MenuButton

var resolutions := ["1440", "1080"]

func _ready() -> void:
	options_menu.visible = false
	pause_menu.visible = false
	
	var popup = resolution_menu.get_popup()
	popup.id_pressed.connect(_set_resolutions)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_continue_pressed() -> void:
	pause_menu.visible = !pause_menu.visible
	pause_menu.get_parent().visible = false
	if pause_menu.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_options_pressed() -> void:
	if options_menu.visible:
		pause_menu.visible = true
		options_menu.visible = false
	else:
		pause_menu.visible = false
		options_menu.visible = true

func _set_resolutions(id) -> void:
	if id == 1:
		get_window().size = Vector2(2560,1440)


func _on_fullscreen_pressed() -> void:
	get_window().mode = 3

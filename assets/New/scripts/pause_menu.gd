extends Control

@onready var main_node := $main
@onready var options_node := $options
@onready var resolution_menu: OptionButton = $options/PanelContainer/MarginContainer/VBoxContainer/OptionButton
@onready var window_mode_menu: OptionButton = $options/PanelContainer/MarginContainer/VBoxContainer/window_mode

var resolutions = [
"2560x1440",
"1920x1080",
"1366x768",
"1280x720"]

func _ready() -> void:
	main_node.visible = false
	options_node.visible = false
	add_resolution()
	add_window_modes()
	resolution_menu.select(1)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if !options_node.visible: main_node.visible = not main_node.visible
		else: options_node.visible = not options_node.visible
		
		if main_node.visible: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else: Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func add_resolution():
	for i in resolutions:
		resolution_menu.add_item(i)

func add_window_modes():
	window_mode_menu.add_item("Windowed")
	window_mode_menu.add_item("Fullscreen")

func _on_options_pressed() -> void:
	options_node.visible = true
	main_node.visible = false

func _on_back_pressed() -> void:
	options_node.visible = false
	main_node.visible = true

func _on_continue_pressed() -> void:
	options_node.visible = false
	main_node.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_option_button_item_selected(index: int) -> void:
	if index == 0: get_viewport().size = Vector2(2560,1440)
	elif index == 1: get_viewport().size = Vector2(1920,1080)
	elif index == 2: get_viewport().size = Vector2(1366,768)
	elif index == 3: get_viewport().size = Vector2(1280,720)

func _on_window_mode_item_selected(index: int) -> void:
	if index == 0: get_window().mode = 0
	elif index == 1: get_window().mode = 3 

extends Node

@onready var pause_menu: Control = get_node("/root/main/Main menu") 

func _ready() -> void:
	pause_menu.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			pause_menu.visible = !pause_menu.visible
			pause_menu.get_child(0).visible = !pause_menu.get_child(0).visible 
			if pause_menu.visible:	
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				pause_menu.get_child(0).visible = true
				pause_menu.get_child(1).visible = false
			else:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

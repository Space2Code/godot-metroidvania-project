extends Node

@onready var mainmenu: Control = get_node("/root/main/Main menu") 

func _ready() -> void:
	mainmenu.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			mainmenu.visible = !mainmenu.visible
			if mainmenu.visible:	
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			else:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

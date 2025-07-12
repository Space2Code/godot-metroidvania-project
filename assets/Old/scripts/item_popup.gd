extends Control

@export var item_name: String = "null"
@export var item_color: String = "#FFFFFF"
@export var item_descripiton: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et ultrices dui. Suspendisse potenti. Quisque ut interdum nulla, ut consequat dolor. Nulla augue felis, dignissim ut tristique eu, euismod id velit."

var title_label: Label
var description_label: Label 

func _ready() -> void:
	title_label = get_node("PanelContainer/MarginContainer/VBoxContainer/item_name")
	description_label = get_node("PanelContainer/MarginContainer/VBoxContainer/MarginContainer2/item_description")
	
	_name_items(item_name, item_color, item_descripiton)

func _name_items(title, color, description):
	title_label.text = title
	description_label.text = description
	title_label.add_theme_color_override("font_color",Color(color))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("clear"):
		visible == false

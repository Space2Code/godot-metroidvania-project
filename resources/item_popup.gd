extends Control

@export var item_name: String = "null"
@export var item_color: String = "#FFFFFF"
@export var item_descripiton: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et ultrices dui. Suspendisse potenti. Quisque ut interdum nulla, ut consequat dolor. Nulla augue felis, dignissim ut tristique eu, euismod id velit."

func _ready() -> void:
	var title_label: Label = get_node("PanelContainer/MarginContainer/VBoxContainer/item_name")
	var description_label: Label = get_node("PanelContainer/MarginContainer/VBoxContainer/MarginContainer2/item_description")
	
	title_label.text = item_name
	description_label.text = item_descripiton
	
	title_label.add_theme_color_override("font_color",Color(item_color))

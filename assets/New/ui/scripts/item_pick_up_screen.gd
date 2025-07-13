extends Control

@export var item_texture: Texture

@onready var item_texture_node: TextureRect = $PanelContainer/VBoxContainer/MarginContainer2/CenterContainer/TextureRect

func _ready() -> void:
	item_texture_node.texture = item_texture
	visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var tween = get_tree().create_tween()
		tween.tween_property(self,"modulate",Color(1.0, 1.0, 1.0, 0.0), 0.5).set_trans(Tween.TRANS_SINE)
		tween.tween_property(self,"visible",false,0)
		

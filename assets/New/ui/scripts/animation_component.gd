class_name AnimationComponent extends Node

@export var position: Vector2 = Vector2(0,0)
@export var rotation: float  = 0.0
@export var scale: Vector2 = Vector2(1,1)
@export var time: float = 0.1
@export var transisiton_type: Tween.TransitionType
@export var ease_type: Tween.EaseType

var target: Control
var default_scale: Vector2

func _ready() -> void:
	target = get_parent()
	default_scale = target.scale

	call_deferred("setup")
	
func setup() -> void:
	target.pivot_offset = target.size/2
	
	animation_loop()
	
func _process(delta: float) -> void:
	pass

func animation_loop() -> void:
	bobing_back_and_forth("rotation_degrees", rotation, time, 0)

func bobing_back_and_forth(property: String, value, seconds: float, loops: int) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(target, property, value, seconds).set_trans(transisiton_type).set_ease(ease_type)
	tween.tween_property(target, property, -value, seconds).set_trans(transisiton_type).set_ease(ease_type)
	tween.set_loops(loops)

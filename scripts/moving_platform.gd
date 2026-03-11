extends Node2D
class_name MovingPlatform

@export var pathFollow2D : PathFollow2D

func _ready() -> void:
	move_tween()

func move_tween() -> void:
	var tween = get_tree().create_tween().set_loops()
	tween.tween_property(pathFollow2D, "progress_ratio", 1.0, 3.0)
	tween.tween_property(pathFollow2D, "progress_ratio", 0.0, 3.0)

extends Node2D

@export var player : Player
@export var animation_player : AnimationPlayer
@export var sprite : Sprite2D

func _process(delta: float) -> void:
	if player.is_on_floor():
		animation_player.play("crouch")
	elif !player.is_on_floor():
		animation_player.play("jump")
	elif Input.is_action_pressed("jump"):
		animation_player.play("idle")

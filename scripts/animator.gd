extends Node2D

@export var player : Player
@export var animation_player : AnimationPlayer
@export var sprite : Sprite2D

func _process(_delta: float) -> void:
	if player.direction == 1:
		sprite.flip_h = true
	elif player.direction == -1:
		sprite.flip_h = false
	
	if player.is_on_floor() or player.velocity.y < 0:
		animation_player.play("land")
	elif player.releaseChute:
		animation_player.play("falling")
	else:
		animation_player.play("jump")

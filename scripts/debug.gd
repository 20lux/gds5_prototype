extends Control

@export var player : Player

@onready var originalPosition = player.global_position

func debug_text() -> void:
	$Label_playervelocity/playervelocity.text = str(player.velocity)
	$Label_playerjumppower/playerjumppower.text = str(player.jump_power)
	$Label_playerjumpmagnitude/playerjumpmagnitude.text = str(player.jump_magnitude)
	$Label_distancefromorigin/distancefromorigin.text = str(originalPosition - player.global_position)
	$jumpnum.text = str(player.jumpNum)

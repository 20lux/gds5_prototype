extends Node2D

@export var audioPlayer : AudioStreamPlayer

func _process(delta: float) -> void:
	if !audioPlayer.playing:
		audioPlayer.play()
	

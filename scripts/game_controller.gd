extends Node2D

@export var audioPlayer : AudioStreamPlayer

func _process(delta: float) -> void:
	if !audioPlayer.playing:
		audioPlayer.play()
	
	#Debug layer
	$CanvasLayer/Debug.debug_text()

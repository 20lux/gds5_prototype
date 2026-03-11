extends Node2D

@export var audioPlayer : AudioStreamPlayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if !audioPlayer.playing:
		audioPlayer.play()

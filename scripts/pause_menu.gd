extends Control

func _ready() -> void:
	$AnimationPlayer.play("RESET")
	$PanelContainer/VBoxContainer/VolumeLabel/VolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(0))

func resume() -> void:
	get_tree().paused = false
	$AnimationPlayer.play_backwards("fade_in")

func pause() -> void:
	get_tree().paused = true
	$AnimationPlayer.play("fade_in")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()

func _on_resume_button_pressed() -> void:
	apply_volume()
	resume()

func _on_restart_button_pressed() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func apply_volume() -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db($PanelContainer/VBoxContainer/VolumeLabel/VolumeSlider.value))

func _on_volume_slider_mouse_exited() -> void:
	release_focus()

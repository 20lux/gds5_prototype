extends Node2D

func _on_portal_area_2d_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		$applause.play()
	else:
		$applause.stop()

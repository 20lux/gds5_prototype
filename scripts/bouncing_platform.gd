extends Area2D

@export var animationPlayer : AnimationPlayer
@export var bounceIntensity = -300.0

func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		animationPlayer.play("bounce")
		body.velocity.y += bounceIntensity
		

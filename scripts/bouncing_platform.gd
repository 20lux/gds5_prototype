extends Area2D

@export var bounceIntensity = -300.0
var animationPlayer : AnimationPlayer

func _ready() -> void:
	animationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		animationPlayer.play("jump")
		body.velocity.y += bounceIntensity
		body.jumpNum = 0

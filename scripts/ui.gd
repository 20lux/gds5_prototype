extends Control

@export var player : Player
@export var bar : ColorRect
var bar_size_max : float

func _ready() -> void:
	bar = $Bar
	bar.color = Color.GREEN
	bar_size_max = 1138.0

func _process(_delta: float) -> void:
	if Input.is_action_pressed("jump"):
		if player.jumpNum == 0:
			bar.size.x = bar_size_max * 0.1
			bar.color = Color.GREEN
		elif player.jumpNum == 1:
			bar.size.x = bar_size_max * 0.25
			bar.color = Color.ORANGE
		elif player.jumpNum == 2:
			bar.size.x = bar_size_max * 0.5
			bar.color = Color.ORANGE_RED
		elif player.jumpNum == 3:
			bar.size.x = bar_size_max * 0.75
			bar.color = Color.RED
		elif player.jumpNum == 4:
			bar.size.x = bar_size_max
			bar.color = Color.BLACK

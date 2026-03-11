extends CharacterBody2D
class_name Player

@export var speed = 100.0
@export var jump_power = -300.0
@export var jump_magnitude = 2
@export var originalPosition : Vector2
@export var currentPosition: Vector2

var playerVelocity : Label
var playerJumpPower: Label
var playerJumpMagnitude : Label
var distanceFromOrigin: Label
var numOfJumps : Label

var jumpLimit = 3
var jumpNum = 0

var maxVelocity = 600.0
var minVelocity = -600.0

@onready var audio_jump = $Animator/audio_jump

func _ready() -> void:
	playerVelocity = $Control/Label_playervelocity/playervelocity
	playerJumpPower = $Control/Label_playerjumppower/playerjumppower
	playerJumpMagnitude = $Control/Label_playerjumpmagnitude/playerjumpmagnitude
	distanceFromOrigin = $Control/Label_distancefromorigin/distancefromorigin
	originalPosition = $"../OriginalPosition".global_position
	currentPosition = position
	numOfJumps = $Control/jumpnum

func _physics_process(delta: float) -> void:
	clampf(velocity.y, minVelocity, maxVelocity)
	
	# Add the gravity and default movement
	if !is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.y = jump_power
		jumpNum = 0

	# Add jump magnitude to velocity
	if Input.is_action_just_pressed("jump") and !is_on_floor() and jumpNum <= jumpLimit:
		# only if player is rising
		if velocity.y < 0:
			audio_jump.play()
			jumpNum += 1
			velocity.y *= jump_magnitude
		
	## Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	
	# Debug
	currentPosition = position
	distanceFromOrigin.text = str(originalPosition - currentPosition)
	playerVelocity.text = str(velocity.y)
	playerJumpPower.text = str(jump_power)
	playerJumpMagnitude.text = str(jump_magnitude)
	numOfJumps.text = str(jumpNum)

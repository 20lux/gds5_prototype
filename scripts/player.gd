extends CharacterBody2D
class_name Player

@export var speed = 100.0
@export var jump_power = -300.0
@export var jump_magnitude = 2
@export var originalPosition : Vector2
var currentPosition: Vector2
var jet_particles : CPUParticles2D
var jumpLimit = 3
var jumpNum = 0

var maxVelocity = 600.0
var minVelocity = -600.0

var gradient : Gradient

@onready var audio_jump = $Animator/audio_jump

func _physics_process(delta: float) -> void:
	clampf(velocity.y, minVelocity, maxVelocity)
	
	# Add the gravity and default movement
	if !is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.y = jump_power
		jumpNum = 0
		jet_particles.emitting = false

	# Add jump magnitude to velocity
	if Input.is_action_just_pressed("jump") and !is_on_floor() and jumpNum <= jumpLimit:
		# only if player is rising
		if velocity.y < 0:
			jet_particles.emitting = true
			audio_jump.play()
			jumpNum += 1
			velocity.y *= jump_magnitude
			if jumpNum == 1:
				jet_particles.color = Color.BROWN
				jet_particles.amount += 2
			elif jumpNum == 2:
				jet_particles.color = Color.ORANGE_RED
				jet_particles.amount += 2
			elif jumpNum == 3:
				jet_particles.color = Color.RED
				jet_particles.amount += 2
			elif jumpNum == 4 and Input.is_action_pressed("jump"):
					velocity.y = -10
					jet_particles.color = Color.BLACK
					jet_particles.amount += 2
			else:
				jet_particles.color = Color.DARK_GRAY
				jet_particles.amount = 3
		
	## Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

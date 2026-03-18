extends CharacterBody2D
class_name Player

@export var speed = 200.0
@export var jump_power = -300.0
@export var jump_magnitude = 2
@export var originalPosition : Vector2
var currentPosition: Vector2
var jumpLimit = 3
var jumpNum = 0
var direction = 0

var falling_grav : Vector2

var maxVelocity = 600.0
var minVelocity = -600.0

@onready var jet_particles = $JetParticles
@onready var wrong_particles = $WrongParticles

@onready var audio_jump = $Animator/audio_jump
@onready var audio_wrong = $Animator/audio_wrong
@export var pitch_shift : AudioEffect

func _ready() -> void:
	falling_grav = Vector2(0, 100)

func _physics_process(delta: float) -> void:
	clampf(velocity.y, minVelocity, maxVelocity)
	
	# Add the gravity and default movement
	if !is_on_floor() and jumpNum <= jumpLimit:
		velocity += get_gravity() * delta
		speed = 200
	elif !is_on_floor() and jumpNum > jumpLimit:
		velocity += falling_grav * delta
		speed = 100
	elif is_on_floor():
		velocity.y = jump_power
		jumpNum = 0

	# Add jump magnitude to velocity
	if Input.is_action_just_pressed("jump") and !is_on_floor() and jumpNum <= jumpLimit:
		# only if player is rising
		if velocity.y < 0 and jumpNum <= jumpLimit:
			audio_jump.play()
			jumpNum += 1
			velocity.y *= jump_magnitude
			if jumpNum == 1:
				jet_particles.emitting = true
				jet_particles.color = Color.WHITE
			elif jumpNum == 2:
				jet_particles.emitting = true
				jet_particles.color = Color.DARK_GRAY
			elif jumpNum == 3:
				jet_particles.emitting = true
				jet_particles.color = Color.DIM_GRAY
	elif Input.is_action_just_pressed("jump") and jumpNum == 4 or velocity.y > 500:
		audio_wrong.play()
		velocity.y = lerpf(velocity.y, 0, 1.0)
		jet_particles.emitting = true
		wrong_particles.emitting = true
		jet_particles.color = Color.BLACK

	## Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

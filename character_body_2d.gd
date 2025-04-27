extends CharacterBody2D


const SPEED = 110.0
const JUMP_VELOCITY = -300.0
var jumpcount = 0
var maxjump = 2
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if is_on_floor():
		jumpcount = 0
	if Input.is_action_just_pressed("jump") and jumpcount < maxjump:
		velocity.y = JUMP_VELOCITY
		jumpcount += 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.x > 0:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = false
		elif velocity.x < 0:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = true
		if Input.is_action_pressed("run"):
			velocity.x = direction * SPEED * 1.8



	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


	move_and_slide()

@onready var _animated_sprite = $AnimatedSprite2D

func _process(_delta):
	if not is_on_floor():
		_animated_sprite.play("jump")
	elif is_on_floor() and Input.is_action_pressed("move_right"):
		_animated_sprite.play("walk")
	elif is_on_floor() and Input.is_action_pressed("move_left"):
		_animated_sprite.play("walk")

	
	elif is_on_floor() and not Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		_animated_sprite.play("sit")

extends CharacterBody2D
## Simple platformer player: run left/right and jump with gravity.
## Kept intentionally small so new mechanics can be layered on later.

@export var speed: float = 220.0          # horizontal run speed (px/sec)
@export var jump_velocity: float = -430.0 # upward impulse on jump (negative = up)

# Pull the project's default gravity so tuning stays in one place.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity", 980.0)


func _physics_process(delta: float) -> void:
	# Apply gravity while airborne.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump only when standing on something.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Horizontal movement: -1 (left), 0 (idle), +1 (right).
	var direction: float = Input.get_axis("move_left", "move_right")
	if direction != 0.0:
		velocity.x = direction * speed
	else:
		# Decelerate smoothly to a stop when no key is held.
		velocity.x = move_toward(velocity.x, 0.0, speed)

	move_and_slide()

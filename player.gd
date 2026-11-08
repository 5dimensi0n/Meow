extends CharacterBody2D

signal state1
const SPEED = 300.0
const GRAVITY = 1
const maxSPEED = 1000.0
const ACCEL = 800.0
const DECEL = 800.
const JUMP_VELOCITY = -400.0
var has_tweened: bool = false
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * maxSPEED, ACCEL * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECEL * delta)

	move_and_slide()
	
	for i in get_slide_collision_count():

		var collision := get_slide_collision(i)
		var collider := collision.get_collider()
		if collider is RigidBody2D: 
			var push_force := 1000.0
			var push_direction := -collision.get_normal()
			collider.apply_central_impulse(push_direction * push_force * delta)
			if collider.name == "Block":
				state1.emit()

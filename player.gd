extends CharacterBody2D

signal state_changed(frame_index: int)

const SPEED = 300.0
const GRAVITY = 1
const maxSPEED = 1000.0
const ACCEL = 800.0
const DECEL = 800.
const JUMP_VELOCITY = -400.0

var health = 200

var has_tweened: bool = false
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	look_at(get_global_mouse_position())
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
			if collider.name == "Enemy":
				health -= 1
				print(health)
				if health == 190:
					state_changed.emit(1)
				if health == 180:
					state_changed.emit(2)
				if health == 170:
					state_changed.emit(3)
				if health == 160:
					state_changed.emit(4)
				if health == 140:
					get_tree().change_scene_to_file("res://Scenes/dead.tscn")
				$"..".shake(10.0)

extends RigidBody2D
signal state_Enemy(frame_index: int)
@export var speed: float = 250.0
var direction  = Vector2.from_angle(randf_range(0, 1* PI))
var health = 200
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 4
	self.linear_velocity = direction * speed
	

func _physics_process(delta: float) -> void:
	for body in get_colliding_bodies():
		direction = global_position.direction_to($"../Player".global_position)
		self.linear_velocity = direction * speed
		if body == $"../Block":
			health -= 1
			if health == 190:
				state_Enemy.emit(1)
			if health == 180:
				state_Enemy.emit(2)
			if health == 170:
				state_Enemy.emit(3)
			if health == 160:
				state_Enemy.emit(4)

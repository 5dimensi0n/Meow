extends RigidBody2D
signal state_Enemy(frame_index: int)
@export var speed: float = 250.0
var direction  = Vector2.from_angle(randf_range(0, 1* PI))
var health = 200
var currentlychasing: bool = false
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 4
	self.linear_velocity = direction * speed
	
	
func _physics_process(delta: float) -> void:
	if currentlychasing == true:
		direction = global_position.direction_to($"../Player".global_position)
		self.linear_velocity = direction * speed
	for body in get_colliding_bodies():
		direction = global_position.direction_to($"../Player".global_position)
		self.linear_velocity = direction * speed
		if body == $"../Block":
			currentlychasing = false
			direction = global_position.direction_to(-$"../Player".global_position)
			self.linear_velocity = direction * speed
			health -= 1
			if health == 190:
				state_Enemy.emit(1)
				$AnimatedSprite2D.frame = 1
				
			if health == 180:
				state_Enemy.emit(2)
				$AnimatedSprite2D.frame = 2
			if health == 170:
				state_Enemy.emit(3)
				$AnimatedSprite2D.frame = 3
			if health == 160:
				state_Enemy.emit(4)
				$AnimatedSprite2D.frame = 4
			if health == 150:
				get_tree().change_scene_to_file("res://Scenes/Win.tscn")
			$"..".shake(2.0)
		else:
			currentlychasing = true

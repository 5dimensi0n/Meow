extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shift"):
		pass
	

func _on_player_state_1() -> void:
	var player = $Player
	if player.health == 990:
		var max_frames = self.sprite_frames.get_frame_count(self.animation)
		self.frame = (self.frame + 1) % max_frames

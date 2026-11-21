extends AnimatedSprite2D
var has_tweened: bool = false
func play_bounce():
	var tween := create_tween()
	tween.tween_property(self, "position:y", -20.0, 0.2).as_relative() \
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y", 22.0, 0.2).as_relative() \
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_player_state_1(frame_index: int) -> void:
	self.frame = frame_index


func _on_player_state_changed(frame_index: int) -> void:
	self.frame = frame_index
	self.play_bounce()
	

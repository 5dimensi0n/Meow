extends AnimatedSprite2D
var has_tweened: bool = false
func play_bounce():
	if has_tweened:
		return
	has_tweened = true
	var tween := create_tween()
	tween.tween_property(self, "position:y", -20.0, 0.2).as_relative() \
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y", 20.0, 0.2).as_relative() \
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.finished.connect(func(): has_tweened = false)
func _on_player_state_changed(frame_index: int) -> void:
	self.frame = frame_index
	self.play_bounce()
	

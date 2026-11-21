extends RichTextLabel

@export var chars_per_second: float = 50.0
var _tween: Tween

var dialogueIndex = 0

func _ready() -> void:
	show_text("This is you.")
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if _tween and _tween.is_valid() and _tween.is_running():
			skip_typing()
		else:
			dialogueIndex += 1
			if dialogueIndex == 1:
				show_text("Every night you have the same dream. You are but a small bug, fighting for your life")
			if dialogueIndex == 2:
				show_text("Try not to die")
			if dialogueIndex == 3:
				get_tree().change_scene_to_file("res://Scenes/level.tscn")
func show_text(bbcode_text: String) -> void:
	text = bbcode_text
	visible_characters = 0

	if _tween and _tween.is_valid():
		_tween.kill()

	var total_chars := get_total_character_count()
	if total_chars <= 0:
		return

	var duration: float = total_chars / max(chars_per_second, 0.001)
	_tween = create_tween()
	_tween.tween_property(self, "visible_characters", total_chars, duration)

func skip_typing() -> void:
	if _tween and _tween.is_valid():
		_tween.kill()
	visible_characters = -1

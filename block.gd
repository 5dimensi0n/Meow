extends RigidBody2D
var is_dragging: bool = false
var mouse_offset: Vector2 = Vector2.ZERO
var has_tweened: bool = false

func play_bounce():
	if has_tweened:
		return
	has_tweened = true
	var tween = create_tween()
	tween.tween_property($Sprite2D, "scale:x", 1.7, 0.1).from(0.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	tween.tween_property($Sprite2D, "scale:x", 1.0, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	
	tween.finished.connect(func(): has_tweened = false)

func _ready() -> void:
	input_pickable = true

func _input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			play_bounce()
			is_dragging = true
			freeze = true 
			mouse_offset = global_position - get_global_mouse_position()
	   
		else:
			if is_dragging:
				is_dragging = false
				freeze = false 
				linear_velocity = Input.get_last_mouse_velocity() * 0.5 

func _physics_process(_delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position() + mouse_offset

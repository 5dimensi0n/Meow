extends Node2D
var _shake_strength: float = 0.0
var _decay_rate: float = 5.0
var _last_camera: Camera2D = null

func shake(strength: float, decay: float = 5.0) -> void:
	_shake_strength = max(_shake_strength, strength)
	_decay_rate = decay


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var cam := get_viewport().get_camera_2d()
	
	# Reset the previous camera if we switched mid-shake
	if _last_camera and _last_camera != cam and is_instance_valid(_last_camera):
		_last_camera.offset = Vector2.ZERO
	_last_camera = cam
	
	if not cam:
		return
		
	if _shake_strength > 0.01:
		cam.offset = Vector2(
			randf_range(-_shake_strength, _shake_strength),
			randf_range(-_shake_strength, _shake_strength)
		)
		_shake_strength = lerp(_shake_strength, 0.0, _decay_rate * delta)
	else:
		_shake_strength = 0.0
		cam.offset = Vector2.ZERO
	if Input.is_action_just_pressed("Shift"):
		if $Player/Camera2D2.is_current():
			$Block/Camera2D1.make_current()
		else:
			$Player/Camera2D2.make_current()
			
	
	
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Shift"):
		if $Player/Camera2D2.is_current():
			$Block/Camera2D1.make_current()
		else:
			$Player/Camera2D2.make_current()

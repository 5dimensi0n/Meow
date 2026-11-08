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

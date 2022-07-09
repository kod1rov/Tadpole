extends Area2D

onready var bodyStick = $BodyStick
onready var stick = $BodyStick/Stick

onready var max_distance = $MAX.shape.radius

var touched = false

func _input(event):
	if event is InputEventScreenTouch:
		var distance = event.position.distance_to(bodyStick.global_position)
		if not touched:
			if distance < max_distance:
				touched = true
			else:
				stick.position = Vector2(0, 0)
				touched = false

func _process(delta):
	if touched:
		stick.global_position = get_global_mouse_position()
		stick.position = bodyStick.position + (stick.position - bodyStick.position).clamped(max_distance)
		
func get_velo():
	var joystick_velo = Vector2(0, 0)
	joystick_velo.x = stick.position.x / max_distance
	joystick_velo.y = stick.position.y / max_distance
	return joystick_velo

extends AnimatedSprite2D

var stop_following:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if stop_following:
		return
	
	var mouse_position:Vector2 = get_global_mouse_position()
	var player_position:Vector2 = get_parent().global_position
	if (mouse_position<player_position):
		look_left(mouse_position)
	else:
		look_right(mouse_position)
		
		
	#look_at(mouse_position)
	
	var target_vec := mouse_position - global_position
	
	if not target_vec.length():
		return
	
	var mouse_boundarie = global_position.angle_to_point(mouse_position)
	
	
	var target_rotation := lerp_angle(global_rotation, mouse_boundarie,5*delta)


	if (flip_v):
		if (abs(target_rotation) < 0.9*PI):
			target_rotation = 0.9*PI * sign(target_rotation)
	else:
		if (abs(target_rotation) > 0.1*PI):
			target_rotation = 0.1*PI * sign(target_rotation)
	global_rotation = target_rotation
	
	
	pass
	
func _input(event):
	
	pass
		

func look_left(mouse_position:Vector2):
	position.x = -1
	flip_v = true
	
	pass

func look_right(mouse_position:Vector2):
	position.x = -1
	flip_v = false
	pass

func do_canalisation_animation() -> void:
	play("eye_close")
	stop_following = true
	pass

func end_canalisation_animation() -> void:
	play("default")
	stop_following = false
	pass

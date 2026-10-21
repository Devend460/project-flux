extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass


func look_left():

	flip_h = true
	flip_v = true
	position.x = -2
	pass

func look_right():

	flip_h = false
	flip_v = false
	position.x = 2
	pass

func look_at_explosion(explosion_global_position:Vector2) -> void:

	if (explosion_global_position<global_position):
		look_left()
	else:
		look_right()
		
		
	#look_at(mouse_position)
	
	var target_vec := explosion_global_position - global_position
	
	if not target_vec.length():
		return
	
	global_rotation = global_position.angle_to_point(explosion_global_position) - PI/2
	
	
	pass

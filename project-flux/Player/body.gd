extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass


func look_left():
	flip_h = true
	position.x = -1
	pass

func look_right():
	flip_h = false
	position.x = 0
	pass

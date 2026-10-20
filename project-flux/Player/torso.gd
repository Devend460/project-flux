extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_charging(time_cost:float) -> void:

	speed_scale = 8/time_cost
	play("Charging")

	#$ChargingFrameTimer.wait_time = time_cost/9.0
	#$ChargingFrameTimer.start()

func look_left():
	flip_h = true
	position.x = -1
	pass

func look_right():
	flip_h = false
	position.x = 0
	pass


func _on_animation_finished() -> void:
	if animation == "Charging":
		speed_scale = 1
		play("default")
	pass # Replace with function body.

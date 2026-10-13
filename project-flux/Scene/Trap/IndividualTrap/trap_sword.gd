extends Trap
class_name TrapSword

enum TrapState{
	START,
	IDLE,
	END
}

var cur_state:TrapState = TrapState.END
@export var looping = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	if cur_state == TrapState.END:
		$AnimatedSprite2D.play("start")
		cur_state = TrapState.START
	if cur_state == TrapState.IDLE:
		$AnimatedSprite2D.play("end")
		cur_state = TrapState.END
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished() -> void:
	if cur_state == TrapState.START:
		$AnimatedSprite2D.play("idle")
		cur_state = TrapState.IDLE
		$Timer.wait_time = 3;
		$Timer.start()
	if cur_state == TrapState.END:
		if looping:
			$Timer.wait_time = 1;
			$Timer.start()
		else:
			queue_free()
	pass # Replace with function body.


func _on_area_2d_area_entered(area: Area2D) -> void:
	var body:Node2D = area.get_parent()

	if body is Player:
		var cur_player = body as Player
		add_to_player(cur_player)
		cur_player.hurt(damage)
	pass # Replace with function body.


func _on_area_2d_area_exited(area: Area2D) -> void:
	var body:Node2D = area.get_parent()
	if body is Player:
		del_from_player()
	pass # Replace with function body.

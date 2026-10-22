@tool
extends ActionLeaf
class_name WaitLeapAnimation

var anim_finished:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func tick(actor: Node, blackboard: Blackboard) -> int:
	if anim_finished:
		var enemie:Templar = actor as Templar
		enemie.start_leap_timer()
		
		return SUCCESS
	return RUNNING

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "LeapSlash":
		anim_finished = true
	pass # Replace with function body.

@tool
extends ActionLeaf
class_name WaitLeaf


@export var wait_time:float = 1

var initial_animation_ready:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func before_run(actor: Node, blackboard:Blackboard) -> void:
	var enemie:Templar = actor as Templar
	
	enemie.start_initial_leap_timer()

	
func tick(actor: Node, blackboard: Blackboard) -> int:
	
	var enemie:Templar = actor as Templar
	
	if enemie.initial_leap_attaque_ready:
		return SUCCESS

	return RUNNING

@tool
extends ActionLeaf
class_name LeapAction

@export var leap_speed: float = 300.0

var leap_finished:bool = true

var initialisation_finished:bool = false

var target_position:Vector2

var time_gap:float = 0

func before_run(actor: Node, blackboard:Blackboard) -> void:
	var player:Player = blackboard.get_value("target")
	
	target_position = player.global_position
	
	pass

func tick(actor: Node, blackboard: Blackboard) -> int:
	
	time_gap += get_process_delta_time()
	
	if !initialisation_finished:
		return RUNNING
	
	var enemie:Templar = actor as Templar
	
	var direction = (target_position - enemie.global_position).normalized()
	var speed = leap_speed * time_gap
	
	if enemie.global_position.distance_to(target_position) <= speed:
		enemie.global_position = target_position
		return SUCCESS
	
	enemie.global_position += direction * speed
	return RUNNING

@tool
extends ActionLeaf
class_name LeapAction

@export var leap_speed: float = 300.0

@export var leap_duration:float = 0.5

@export var leap_min_range:float = 20

@export var leap_max_range:float = 100.0

var leap_finished:bool = false

var current_tween:Tween

var initialisation_finished:bool = false

var target_position:Vector2

func before_run(actor: Node, blackboard:Blackboard) -> void:
	var enemie:Templar = actor as Templar
	leap_finished = false
	target_position = blackboard.get_value("leap_target")
	var length:float = enemie.global_position.distance_to(target_position)
	if length>leap_max_range:
		var direction = (target_position - enemie.global_position).normalized()
		target_position = enemie.global_position + direction*leap_max_range
	if length<leap_min_range:
		var direction = (target_position - enemie.global_position).normalized()
		target_position = enemie.global_position + direction*leap_min_range
	
	
	if current_tween and current_tween.is_valid():
		current_tween.kill()
		
	current_tween = enemie.create_tween()
	current_tween.tween_property(enemie, "global_position", target_position, leap_duration)
	
	
	current_tween.set_trans(Tween.TRANS_QUAD) 
	current_tween.set_ease(Tween.EASE_IN_OUT)
	
	current_tween.finished.connect(func(): leap_finished = true)
	
	
	pass

func tick(actor: Node, blackboard: Blackboard) -> int:
	
	#var time_gap = get_process_delta_time()
	
	#var enemie:Templar = actor as Templar
	
	#var direction = (target_position - enemie.global_position).normalized()
	#var speed = leap_speed * time_gap
	
	if leap_finished:
		return SUCCESS
	
	#if enemie.global_position.distance_to(target_position) <= speed:
	#	enemie.global_position = target_position
	#	return SUCCESS
	
	#enemie.global_position += direction * speed
	return RUNNING

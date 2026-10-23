extends ActionLeaf


var jump_finished:bool = false

var target_position:Vector2

var current_tween:Tween

@export var travel_duration:float = 0.75

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func before_run(actor: Node, blackboard:Blackboard) -> void:
	var enemie:Templar = actor as Templar
	jump_finished = false
	target_position = blackboard.get_value("jump_target")
	
	
	if current_tween and current_tween.is_valid():
		current_tween.kill()
		
	current_tween = enemie.create_tween()
	current_tween.tween_property(enemie, "global_position", target_position, travel_duration)
	
	
	current_tween.set_trans(Tween.TRANS_QUAD) 
	current_tween.set_ease(Tween.EASE_OUT)
	
	current_tween.finished.connect(func(): jump_finished = true)
	
	
	pass

func tick(actor: Node, blackboard: Blackboard) -> int:
	
	if jump_finished:
		return SUCCESS

	return RUNNING

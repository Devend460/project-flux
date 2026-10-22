@tool
extends ConditionLeaf


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func tick(actor: Node, blackboard: Blackboard) -> int:
	var enemie:Templar = actor as Templar
	var player:Player = blackboard.get_value("target")
	
	var distance = enemie.global_position.distance_to(player.global_position)

	if distance <= 175.0:
		return SUCCESS
		
	return FAILURE

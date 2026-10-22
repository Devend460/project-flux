@tool
extends ActionLeaf
class_name SelectTargetAction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func tick(actor: Node, blackboard: Blackboard) -> int:
	var player:Player = blackboard.get_value("target")
	var enemie:Templar = actor as Templar
	blackboard.set_value("leap_target",player.global_position)
	
	var sword_rot = enemie.global_position.direction_to(player.global_position).angle()
	enemie.sword_rotation.rotation = sword_rot + PI/2
	enemie.stop()
	enemie.animation_player.play("LeapSlash")
	return SUCCESS

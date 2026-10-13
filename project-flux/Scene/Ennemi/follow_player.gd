@tool
extends ActionLeaf
class_name FollowPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func tick(actor: Node, blackboard: Blackboard) -> int:
	var enemie:Templar = actor as Templar
	var player:Player = blackboard.get_value("target")
	enemie.change_direction(enemie.global_position.direction_to(player.global_position))
	if enemie.animation_player.current_animation != "Idle":
		enemie.animation_player.play("Idle")
	return SUCCESS

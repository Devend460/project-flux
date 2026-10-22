@tool
extends ActionLeaf
class_name AttakPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var anim_finished = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func before_run(actor: Node, blackboard: Blackboard) -> void:
	anim_finished = false

func tick(actor: Node, blackboard: Blackboard) -> int:
	var enemie:Templar = actor as Templar
	var player:Player = blackboard.get_value("target")
	if enemie.animation_player.current_animation != "SwordSlash":
		enemie.stop()
		
		var sword_rot = enemie.global_position.direction_to(player.global_position).angle()
		enemie.sword_rotation.rotation = sword_rot + PI/2
		enemie.animation_player.play("SwordSlash")
	if !anim_finished:
		return RUNNING
	enemie.start_slash_timer()
	return SUCCESS


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "SwordSlash":
		anim_finished = true
	pass # Replace with function body.

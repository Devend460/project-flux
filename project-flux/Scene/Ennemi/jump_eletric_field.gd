extends ActionLeaf

var anim_finished:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func before_run(actor: Node, blackboard: Blackboard) -> void:
	anim_finished = false

func tick(actor: Node, blackboard: Blackboard) -> int:
	var enemie:Templar = actor as Templar
	var player:Player = blackboard.get_value("target")
	if enemie.animation_player.current_animation != "ElectricField":
		enemie.stop()
		enemie.animation_player.play("ElectricField")
	if !anim_finished:
		return RUNNING
	return SUCCESS


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "ElectricField":
		anim_finished = true
	pass # Replace with function body.

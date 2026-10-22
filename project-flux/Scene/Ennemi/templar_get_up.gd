extends ActionLeaf

var anim_finished = false

var enemie:Templar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func before_run(actor: Node, blackboard: Blackboard) -> void:
	enemie = actor as Templar
	anim_finished = false
	enemie.stop()
	enemie.templar_sprite.play("Reset_electric")
	pass

func tick(actor: Node, blackboard: Blackboard) -> int:
	
	if anim_finished:
		return SUCCESS
	return RUNNING


func _on_templar_sprite_animation_finished() -> void:
	if enemie != null:
		if enemie.templar_sprite.animation == "Reset_electric":
			anim_finished = true
	pass # Replace with function body.

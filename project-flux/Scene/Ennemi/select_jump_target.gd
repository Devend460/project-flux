extends ActionLeaf


@export var audio_stream:AudioStream = preload("res://Sound/SFX/Jump.mp3")

@export var volume_db:float = 0.0

@export var pitch:float = 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func tick(actor: Node, blackboard: Blackboard) -> int:
	var player:Player = blackboard.get_value("target")
	var enemie:Templar = actor as Templar
	blackboard.set_value("jump_target",player.global_position)
	enemie.play_sound(audio_stream,volume_db,pitch)
	return SUCCESS

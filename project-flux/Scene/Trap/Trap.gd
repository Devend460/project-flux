extends Node2D
class_name Trap

var player:Player

@export
var damage:int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_trap() -> void:
	pass

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_PREDELETE:
			on_predelete()

func on_predelete() -> void:
	if player != null:
		del_from_player()
	pass

func add_to_player(new_player:Player) -> void:
	player = new_player
	player.cur_trap_overlap.append(self)
	
func del_from_player() -> void:
	var index = player.cur_trap_overlap.find(self)
	if index != -1:
		player.cur_trap_overlap.remove_at(index)
	pass

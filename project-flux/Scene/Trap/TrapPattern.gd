extends Node2D
class_name TrapPatern

var tileManager:TileManager

var second_phase:bool = false

signal trap_pattern_ended

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Activation of the trap
#Must call super at the end so the trap Patern can spawn itself (ex : Need timer)
func spawn_trap() -> TrapPatern:
	return self

func send_end_signal() -> void:
	trap_pattern_ended.emit()
	pass

func start_second_phase() -> void:
	second_phase = true

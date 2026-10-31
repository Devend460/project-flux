extends Node2D
class_name TrapCreator

var second_phase = false

signal second_phase_trigger

var TrapDict = {
	1:preload("res://Scene/Trap/TrapSwordPattern.tscn"),
	2:preload("res://Scene/Trap/blanc_tile_patern_debug.tscn")
}

enum TrapName{
	None = 0,
	TrapSword = 1,
	BlancDebug = 2
}

@export var activate_trap = true

@export var tileManager:TileManager

@export var trapToCreate:TrapName

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if tileManager == null:
		tileManager = get_parent().tile_manager
	activate_trap = get_parent().activate_Trap
	if activate_trap:
		spawn_current_trap()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_current_trap() -> void:
	if trapToCreate == TrapName.None:
		return
	var cur_trap:TrapPatern = TrapDict.get(trapToCreate).instantiate()
	if (cur_trap == null):
		print("TRAP NULL")
	cur_trap.tileManager = tileManager
	add_child(cur_trap)
	cur_trap.trap_pattern_ended.connect(trap_patern_ended)
	second_phase_trigger.connect(cur_trap.start_second_phase)
	cur_trap.spawn_trap()

func trap_patern_ended() -> void:
	spawn_current_trap()


func _on_templar_start_second_phase() -> void:
	second_phase_trigger.emit()
	pass # Replace with function body.

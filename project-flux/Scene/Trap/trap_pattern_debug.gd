extends Node2D

var TrapDict = {
	1:preload("res://Scene/Trap/TrapSwordPattern.tscn")
}

enum TrapName{
	None = 0,
	TrapSword = 1
}


@export var tileManager:TileManager

@export var trapToCreate:TrapName

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if trapToCreate == TrapName.None:
		return
	var cur_trap:TrapPatern = TrapDict.get(trapToCreate).instantiate()
	if (cur_trap == null):
		print("TRAP NULL")
	cur_trap.tileManager = tileManager
	add_child(cur_trap)
	cur_trap.spawn_trap()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

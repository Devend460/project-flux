extends TrapPatern
class_name TrapBlancPatternDebug

var BlancTrap = preload("res://Scene/Trap/IndividualTrap/DebugTileVisuel.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_trap() -> TrapBlancPatternDebug:
	spawn()
	return self

func spawn()->void:
	for x in range(TileManager.ArenaWidth):
		for y in range(TileManager.ArenaHeigh):
			var cur_trap:BlancTrap = BlancTrap.instantiate()
			cur_trap.global_position = TileManager.tile_to_realtl(Vector2(x,y))
			tileManager.add_trap(cur_trap)
	
	
	
	queue_free()
	pass

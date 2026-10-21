extends TrapPatern
class_name TrapSwordPattern

var SwordTrap = preload("res://Scene/Trap/IndividualTrap/Trap_Sword.tscn")

var cur_col = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_trap() -> TrapSwordPattern:
	spawn_col(cur_col)
	$Timer.start()
	return self

func spawn_col(x:int)->void:
	for y in range(TileManager.ArenaHeigh):
		if canplace_trap(x,y):
			var cur_trap:TrapSword = SwordTrap.instantiate()
			cur_trap.global_position = TileManager.tile_to_realtl(Vector2(x,y))
			tileManager.add_trap(cur_trap)
	if x>=TileManager.ArenaWidth-1:
		queue_free()
	cur_col += 1
	pass

func canplace_trap(tileX:int, tileY:int) -> bool:
	if (tileX%2 == 0):
		return true
	return false


func _on_timer_timeout() -> void:
	spawn_col(cur_col)
	pass # Replace with function body.

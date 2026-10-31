extends TrapPatern
class_name TrapSwordPattern

var SwordTrap = preload("res://Scene/Trap/IndividualTrap/Trap_Sword.tscn")

var cur_col = 0

@onready var last_col_trap_array:Array[Trap] = []

@onready var last_col = false

signal fow_material_started

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
			if second_phase:
				cur_trap.activate_fow()
			else:
				fow_material_started.connect(cur_trap.activate_fow)
			tileManager.add_trap(cur_trap)
			if last_col:
				cur_trap.trap_finished.connect(check_trap_existence)
				last_col_trap_array.append(cur_trap)

	cur_col += 1
	pass

func spawn_last_col(x:int) -> void:
	for y in range(TileManager.ArenaHeigh):
		if canplace_trap(x,y):
			var cur_trap:TrapSword = SwordTrap.instantiate()
			cur_trap.global_position = TileManager.tile_to_realtl(Vector2(x,y))
			if second_phase:
				cur_trap.activate_fow()
			else:
				fow_material_started.connect(cur_trap.activate_fow)
			tileManager.add_trap(cur_trap)
			if last_col:
				cur_trap.trap_finished.connect(check_trap_existence)
				last_col_trap_array.append(cur_trap)


func canplace_trap(tileX:int, tileY:int) -> bool:
	if (tileX%2 == 0):
		return true
	return false


func _on_timer_timeout() -> void:
	if cur_col>=TileManager.ArenaWidth-1:
		last_col = true
		$Timer.stop()
		spawn_last_col(cur_col)
	spawn_col(cur_col)
	pass # Replace with function body.

func check_trap_existence(_trap:Trap) -> void:
	var index:int = last_col_trap_array.find(_trap)
	if (index == -1):
		print("BIG PROBLEM")
		return
	last_col_trap_array.remove_at(index)
	if last_col_trap_array.size() == 0:
		send_end_signal()
		queue_free()

func start_second_phase() -> void:
	super()
	fow_material_started.emit()

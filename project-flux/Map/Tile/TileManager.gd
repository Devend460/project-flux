class_name TileManager
extends Node2D

static var TileSize:float = 64;
static var ArenaWidth:int = 18;
static var ArenaHeigh:int = 16;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_trap(trap:Trap) -> void:
	$TrapContainer.add_child(trap)
	pass

var ActualDanger = {}

static func real_to_tile(real_coord:Vector2) -> Vector2:
	return Vector2(floor(real_coord.x/TileSize),floor(real_coord.y/TileSize))

#return the top left pixel coord of the tile
static func tile_to_realtl(tile_coord:Vector2) -> Vector2:
	return tile_coord*TileSize
	

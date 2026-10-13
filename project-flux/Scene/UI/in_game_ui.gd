extends Control

var cur_life = 0;
var nb_heart = 0;

var hbox_list = []

@export var player_character:CharacterBody2D

const HEART_SCENE = preload("res://Scene/UI/heart.tscn");

var player:Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = player_character as Player
	player.life_changed.connect(_on_player_life_changed)
	_on_player_life_changed(player.life)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_life_changed(new_life: int) -> void:
	cur_life = new_life
	update_life_visual()
	pass # Replace with function body.
	
func update_life_visual() -> void:
	var life_variation = cur_life-nb_heart;
	if sign(life_variation) == 1:
		for i in range(life_variation):
			gain_heart()
	elif sign(life_variation) == -1:
		for i in range(-1*life_variation):
			lose_heart()
	pass

func lose_heart() -> void:
	if hbox_list.is_empty() == true:
		pass
	$HBoxContainer.remove_child(hbox_list.pop_back())
	nb_heart -= 1
	pass

func gain_heart() -> void:
	var heart_scene = HEART_SCENE.instantiate()
	hbox_list.push_back(heart_scene)
	$HBoxContainer.add_child(heart_scene)
	nb_heart += 1
	pass

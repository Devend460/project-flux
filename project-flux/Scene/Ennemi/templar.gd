extends Node2D
class_name Templar

@export
var health:int = 10;

@export
var speed:float = 300;

@onready var behave_tree:BeehaveTree = $BeehaveTree

@onready var animation_player:AnimationPlayer = $AnimationPlayer

@onready var sword_rotation:Node2D = $Sword_Rotation

var slash_attaque_ready:bool = true

var move_direction:Vector2 = Vector2.ZERO

var cur_attack:Attack_Type = Attack_Type.NONE

var last_attack:Attack_Type = Attack_Type.NONE

enum Attack_Type {
	NONE = 0,
	FLUX_ZONE = 1,
	NORMAL_SWING = 2,
	LUNGE_SWING = 3,
	JUMP = 4,
	
}



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	behave_tree.blackboard.set_value("target",get_tree().get_first_node_in_group("Player"))
	$AnimatedSprite2D.play("default")
	$AnimationPlayer.play("Idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += move_direction*speed*delta
	pass

func change_direction(new_direction:Vector2) -> void:
	move_direction = new_direction
	pass

func stop() -> void:
	move_direction = Vector2.ZERO
	pass


func _on_slash_timer_timeout() -> void:
	slash_attaque_ready = true
	pass # Replace with function body.

func start_slash_timer() ->void:
	slash_attaque_ready = false
	if $Couldown/SlashTimer.is_stopped():
		$Couldown/SlashTimer.start()


func hurt_player()-> void:
	var player:Player = behave_tree.blackboard.get_value("target")
	player.hurt()
	pass

func hurt() -> void:
	#Verifier si un attaque a deja fait des degats,
	#Le faire du cote de l'explosion peut être ? donc juste faire une fonction hurt et l'attaque gere elle meme
	health -= 1
	print(health)
	if health<= 0 :
		queue_free()
	
	pass

func _on_area_first_sword_area_entered(area: Area2D) -> void:
	hurt_player()
	pass # Replace with function body.


func _on_area_second_sword_area_entered(area: Area2D) -> void:
	hurt_player()
	pass # Replace with function body.

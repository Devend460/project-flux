extends CharacterBody2D
class_name Player

@export var speed: float = 300.0

signal life_changed(new_life:int)

@export var life = 5

#Seulement les piege peuvent réinfliger des dégats apres etre invincible (les coups se font quasi instant, donc le meme coup ne peut pas toucher plusieurs fois)
var cur_trap_overlap:Array[Trap]
#Contient les trap qui touche toujours le player pour verifier au moment ou l;invincibilite se termine
#L'ajout est gerer par les trap elle meme.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	# Get the directional vector from -1 to 1 based on your input actions
	var direction: Vector2 = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	
	# Set velocity and move
	velocity = direction * speed
	move_and_slide()

func hurt(damage:int = 1) -> void:
	if ($InvicibilityTimer.is_stopped()):
		life -= damage
		life_changed.emit(life)
		$InvicibilityTimer.start()


func _on_invicibility_timer_timeout() -> void:
	#Check if player is still on a trap
	if !cur_trap_overlap.is_empty():
		#Pour l'instant pas de double degats donc on peut juste hurt
		hurt()
	pass # Replace with function body.

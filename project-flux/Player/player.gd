extends CharacterBody2D
class_name Player

var has_energy = true

@export var speed: float = 300.0

@export var life = 5

@export var energy_time_cost:float = 8.0

@export var attack_range:float = 100

@export var attack_impulse_force:float = 500

@export var attack_impulse_decay:float = 1200

var attack_location:Vector2

var array_status_effect:Array[StatusEffect] = []

#MEMO : pair {Vector2:Etat de l'impuls, float: taux de decay de l'impulse}
var array_pair_impulse:Array[Array] = []

signal life_changed(new_life:int)

enum StatusEffect{
	None,
	Canalisation
}

var explosion_scene:PackedScene = preload("res://Player/Attaque/Explosion.tscn")

#Seulement les piege peuvent réinfliger des dégats apres etre invincible (les coups se font quasi instant, donc le meme coup ne peut pas toucher plusieurs fois)
var cur_trap_overlap:Array[Trap]
#Contient les trap qui touche toujours le player pour verifier au moment ou l;invincibilite se termine
#L'ajout est gerer par les trap elle meme.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("Sweep"):
		if $EnergyTimer.is_stopped():
			var mouse_position:Vector2 = get_global_mouse_position()
			var direction = global_position.direction_to(mouse_position)
			start_explosion_canalisation(global_position + direction*attack_range)
	pass


func _physics_process(delta: float) -> void:
	# Get the directional vector from -1 to 1 based on your input actions
	var direction:Vector2 = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	
	var walk_velocity = Vector2.ZERO
	
	#Si le joueur peut marcher, sa velocity de base par de sa marche
	if array_status_effect.find(StatusEffect.Canalisation) == -1:
		walk_velocity = do_walking(direction)
	
	var inpulse_velocity = Vector2.ZERO
	
	var pair_to_remove:Array[int] = []
	
	var i:int = 0
	
	for pair in array_pair_impulse:
		inpulse_velocity += pair[0]
		pair[0] = pair[0].move_toward(Vector2.ZERO, pair[1] * delta)
		if pair[0].length() < 1.0:
			pair_to_remove.append(i)
		i += 1
	
	
	for j in range(pair_to_remove.size()):
		array_pair_impulse.remove_at(pair_to_remove[-1])
		pair_to_remove.pop_back()
	
	#Ajout d'autre vecteur a velocity si necessaire
	velocity = walk_velocity + inpulse_velocity
	move_and_slide()

func do_walking(direction:Vector2)->Vector2:
	if direction != Vector2(0,0):
		if $Leg.animation == "default":
			body_animation_walking()
	else:
		if $Leg.animation == "Walking":
			body_animation_default()

	if direction.x >0:
		body_look_right()
	elif direction.x<0:
		body_look_left()
	return direction*speed

func hurt(damage:int = 1) -> void:
	if ($InvicibilityTimer.is_stopped()):
		life -= damage
		life_changed.emit(life)
		
		if life <= 0:
			get_tree().reload_current_scene()
		
		$InvicibilityTimer.start()
		$AnimationPlayer.play("invincibility_frame")


func _on_invicibility_timer_timeout() -> void:
	#Check if player is still on a trap
	if !cur_trap_overlap.is_empty():
		#Pour l'instant pas de double degats donc on peut juste hurt
		hurt()
	else:
		$AnimationPlayer.play("RESET")
	pass # Replace with function body.

func start_explosion_canalisation(explosion_global_position:Vector2) -> void:
	#Securtite
	if array_status_effect.find(StatusEffect.Canalisation) != -1:
		return
	
	
	
	attack_location = explosion_global_position
	
	var inst_explosion:Explosion = explosion_scene.instantiate()
	inst_explosion.initalisation_finished.connect(canalisation_finished)
	get_tree().root.add_child(inst_explosion)
	inst_explosion.global_position = attack_location
	
	#Animation des bras du player
	
	#Freeze du joueur
	array_status_effect.append(StatusEffect.Canalisation)
	
	body_animation_canalisation()
	
	pass

func canalisation_finished() -> void:
	var canalisation_index = array_status_effect.find(StatusEffect.Canalisation)
	if (canalisation_index != -1):
		array_status_effect.remove_at(canalisation_index)
	#Projection du player apres canalisation
	var direction:Vector2 = attack_location.direction_to(global_position)
	add_impulse(direction*attack_impulse_force, attack_impulse_decay)
	
	$EnergyTimer.start(energy_time_cost)
	$Torso.start_charging(energy_time_cost)
	body_animation_endcanalisation()
	pass

func add_impulse(direction:Vector2,decay_rate:float) -> void:
	array_pair_impulse.append([direction,decay_rate])
	pass


func body_look_right() -> void:
	$Torso.look_right()
	$Leg.look_right()
	$LeftArm.look_right()
	$RightArm.look_right()
	pass

func body_look_left() -> void:
	$Torso.look_left()
	$Leg.look_left()
	$LeftArm.look_left()
	$RightArm.look_left()
	pass

func body_animation_canalisation() -> void:
	body_animation_default()
	$Head.do_canalisation_animation()
	#Freeze la tete (suis pus la souris)

func body_animation_endcanalisation() -> void:
	$Head.end_canalisation_animation()
	#Unfreeze

func body_animation_walking() -> void:
	$Leg.play("Walking")
	$LeftArm.play("Walking")
	$RightArm.play("Walking")
	pass

func body_animation_default() -> void:
	$Leg.play("default")
	$LeftArm.play("default")
	$RightArm.play("default")
	pass

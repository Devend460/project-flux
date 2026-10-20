extends Node2D
class_name Explosion

signal initalisation_finished

var has_damaged = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.get_overlapping_areas()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Chargement":
		initalisation_finished.emit()
		$AnimatedSprite2D.speed_scale = 2
		$AnimatedSprite2D.play("Explosion")
		$Area2D.monitoring = true
	elif $AnimatedSprite2D.animation == "Explosion":
		queue_free()
	pass # Replace with function body.


func _on_area_2d_area_entered(area: Area2D) -> void:
	if has_damaged:
		return
	var templar:Templar = area.get_parent() as Templar
	templar.hurt()
	has_damaged = true
	pass # Replace with function body.

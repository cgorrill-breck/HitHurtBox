class_name HurtBox
extends Area2D
signal hurt(hitbox: HitBox, damage)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func take_hit(hitbox : Area2D, damage: int):
	hurt.emit(hitbox, damage)


func _on_area_entered(area: HitBox) -> void:
	if not area is HitBox:
		return
	take_hit(area, area.damage)

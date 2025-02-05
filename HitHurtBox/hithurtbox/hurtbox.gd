class_name HurtBox
extends Area2D
signal hurt(hitbox: HitBox, damage)

func take_hit(hitbox : Area2D, damage: int):
	hurt.emit(hitbox, damage)


func _on_area_entered(area: HitBox) -> void:
	if not area is HitBox:
		return
	take_hit(area, area.damage)

extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var health := 30

func _physics_process(delta: float) -> void:
	if health <= 0:
		die()

func die():
	queue_free()

func _on_hurtbox_hurt(hitbox: HitBox, damage: int) -> void:
	health -= damage
	print("Enemy hit by " + hitbox.get_parent().name)
	hitbox.get_parent().queue_free()

extends CharacterBody2D

const SPEED = 300.0
@export var health := 30

func _physics_process(delta: float) -> void:
	if health <= 0:
		die()

func die():
	queue_free()

func _on_hurtbox_hurt(hitbox: HitBox, damage: int) -> void:
	health -= damage	
	print("Enemy hit by " + hitbox.get_parent().get_name())
	var projectile = hitbox.get_parent()
	if projectile is Projectile:
		if projectile.has_node("CollisionShape2D"):
			projectile.get_node("CollisionShape2D").set_deferred("disabled", true)
		projectile.call_deferred("queue_free")

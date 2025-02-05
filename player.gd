extends CharacterBody2D
"""
Link here: https://youtu.be/mdhKQLUHm2s?si=dgnxiwbNKjVfkTY-
"""

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var projectile_scene : PackedScene

@export var health = 30
@export var defense = 3
func _physics_process(delta: float) -> void:
	
	# Get input for horizontal and vertical movement.
	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	rotate_toward_mouse()
	# Set horizontal movement.
	velocity.x = direction_x * SPEED
	
	# Set vertical movement (only when not affected by gravity, e.g., for flying or free movement).
	if not is_on_floor():  # Remove this condition if you want full up/down movement always.
		velocity.y = direction_y * SPEED

	if health <= 0:
		die()

	# Apply movement.
	move_and_slide()




func rotate_toward_mouse():
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)  # Rotates the player to face the mouse

func die():
	queue_free()

func receive_damage(base_damage : int):
	var actual_damage = base_damage - defense
	health -= actual_damage
	print("Player took " + str(actual_damage) + " points of damage.")


func _on_hurtbox_hurt(hitbox: HitBox, damage: int) -> void:
	print("Player took damage from " + hitbox.get_parent().name)
	receive_damage(damage)

func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		shoot_projectile()

func shoot_projectile():
	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)  # Add to the scene

	# Position it at the player's location
	projectile.global_position = global_position
	projectile.rotation = rotation
	# Apply impulse to launch it in thesd facing direction
	projectile.linear_velocity = (transform.x * projectile.speed)

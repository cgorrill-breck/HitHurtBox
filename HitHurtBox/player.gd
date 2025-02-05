extends CharacterBody2D

const SPEED = 300.0
var base_speed = SPEED

@export var projectile_scene : PackedScene

@export var health = 30
@export var defense = 3

func _ready():
	$Axe.scale = Vector2(4, 4)

func _physics_process(delta: float) -> void:
	
	# Get input for horizontal and vertical movement.
	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	
	rotate_toward_mouse()
	# Set horizontal movement.
	velocity.x = direction_x * base_speed
	velocity.y = direction_y * base_speed

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



func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		shoot_projectile()
	if event.is_action_pressed("chop"):
		$Axe/AnimationPlayer.play("chop")
		await $Axe/AnimationPlayer.animation_finished
		$Axe/AnimationPlayer.play("RESET")
		


func shoot_projectile():
	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)  # Add to the scene
	# Position it at the player's location
	projectile.add_to_group("player_projectiles")
	projectile.global_position = global_position
	projectile.rotation = rotation
	# Apply impulse to launch it in thesd facing direction
	projectile.linear_velocity = (transform.x * projectile.speed)


func _on_hurtbox_hurt(hitbox: HitBox, damage: Variant) -> void:
	print("Player took damage from " + hitbox.get_parent().name)
	receive_damage(damage)

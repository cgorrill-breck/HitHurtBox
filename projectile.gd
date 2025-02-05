extends RigidBody2D
@export var speed: float = 500.0
@export var damage: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	linear_velocity = transform.x * speed

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

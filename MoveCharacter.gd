extends CharacterBody2D
var gravity : Vector2
@export var jump_coefficient : float


# Called when the node enters the scene tree for the first time.
func _ready():
	gravity = Vector2(0, 100)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("move_left"):
		velocity += Vector2(-200,0)
	if Input.is_action_pressed("move_right"):
		velocity += Vector2(200,0)
	if velocity.x > 400:
		velocity = Vector2(400, velocity.y)
	if velocity.x < -400:
		velocity = Vector2(-400, velocity.y)
	if not is_on_floor():
		velocity += gravity
	if is_on_floor():
		velocity = Vector2(velocity.x, 0)
		velocity -= Vector2(velocity.x / 5, 0)
		if Input.is_action_just_pressed("jump"):
			velocity += Vector2(1,-jump_coefficient)
	move_and_slide()
	pass

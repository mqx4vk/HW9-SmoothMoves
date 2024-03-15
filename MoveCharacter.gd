extends CharacterBody2D
var gravity : Vector2
@export var jump_coefficient : float
@export var x_speed : float
@export var x_air_coefficient : float # Should the player move more slowly left and right in the air? Set to zero for no movement, 1 for the same
@export var x_speed_limit : float # What is the max speed? 
@export var x_friction : float 

# Called when the node enters the scene tree for the first time.
func _ready():
	gravity = Vector2(0, 100)
	pass # Replace with function body.


func _get_input():
	if is_on_floor():
		if Input.is_action_pressed("move_left"):
			velocity += Vector2(-x_speed,0)
		if Input.is_action_pressed("move_right"):
			velocity += Vector2(x_speed,0)
		if Input.is_action_just_pressed("jump"): # Jump only happens when we're on the floor (unless we want a double jump, but we won't use that here)
			velocity += Vector2(1,-jump_coefficient)
	if not is_on_floor():
		if Input.is_action_pressed("move_left"):
			velocity += Vector2(-x_speed * x_air_coefficient,0)
		if Input.is_action_pressed("move_right"):
			velocity += Vector2(x_speed * x_air_coefficient,0)

func _limit_speed():
	if velocity.x > x_speed_limit:
		velocity = Vector2(x_speed_limit, velocity.y)
	if velocity.x < -x_speed_limit:
		velocity = Vector2(-x_speed_limit, velocity.y)

func _apply_friction():
	if is_on_floor() and not (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")):
		velocity -= Vector2(velocity.x * x_friction, 0)
		if abs(velocity.x) < 5:
			velocity = Vector2(0, velocity.y) # if the velocity in x gets close enough to zero, we set it to zero

func _apply_gravity():
	if not is_on_floor():
		velocity += gravity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_get_input()
	_limit_speed()
	_apply_friction()
	_apply_gravity()

	move_and_slide()
	pass

extends CharacterBody2D
var gravity : Vector2 #using vector2 because we are in 2d godot
@export var jump_height : float ## How high should they jump?
@export var movement_speed : float ## How fast can they move?
@export var horizontal_air_coefficient : float ## Should the player move more slowly left and right in the air? Set to zero for no movement, 1 for the same
@export var speed_limit : float ## What is the player's max speed? 
@export var friction : float ## What friction should they experience on the ground?

# Called when the node enters the scene tree for the first time.
func _ready():
	gravity = Vector2(0, 100) #set gravity variable to Vector2 value 
	pass # Replace with function body.


func _get_input(): #This function handles all the player input
	if is_on_floor(): #if the character body is on a surface or "floor" 
		if Input.is_action_pressed("move_left"): #if the predetermined "move_left" trigger is pressed/held
			velocity += Vector2(-movement_speed,0)#increase the velocity variable for the character by the negative amount of the movement speed variable (move character left)

		if Input.is_action_pressed("move_right"):#if the predetermined "move_right" trigger is pressed/held
			velocity += Vector2(movement_speed,0)#increase the velocity variable for the character by the amount of the movement speed variable (move the character right)

		if Input.is_action_just_pressed("jump"): # Jump only happens when we're on the floor (unless we want a double jump, but we won't use that here)
			velocity += Vector2(1,-jump_height)#increase the velocity variable for the character by the negative amount of the jump_height variable (move the character up to jump) 

	if not is_on_floor():#if the character is in the air
		if Input.is_action_pressed("move_left"):#If the set "move_left" trigger is pressed/held
			velocity += Vector2(-movement_speed * horizontal_air_coefficient,0)#increase the velocity variable for the character by the negative amount of the movement_speed variable multiplied by the horizontal_air_coefficient(move character left in the air)

		if Input.is_action_pressed("move_right"):#If the set "move_right" triffer is pressed/held
			velocity += Vector2(movement_speed * horizontal_air_coefficient,0)#increase the velocity variable for the character by the amount of the movement_speed variable multiplied by the horizontal_air_coefficient(move character right in the air)

func _limit_speed():#define a function (that limits speed)
	if velocity.x > speed_limit: #if the velocity.x variable's value is greater than the value of the speed limit variable
		velocity = Vector2(speed_limit, velocity.y)#the velocity variable is updated to the value of the speed limit

	if velocity.x < -speed_limit:#if the velocity.x variable's value is less than the negative value of the speed limit variable
		velocity = Vector2(-speed_limit, velocity.y)#the velocity variable is update to the negative value of the speed limit

func _apply_friction():#define a new function (to apply friction)
	if is_on_floor() and not (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")):#if the character is on a surface(the "floor") and also the character is not inputting the set "move_left" or "move_right" trigger
		velocity -= Vector2(velocity.x * friction, 0) #velocity is decreased by the amount of the velocity.x variable's value multiplied by the friction variable's value
		if abs(velocity.x) < 5:#If the absolute value of the velocity.x variable is less than 5
			velocity = Vector2(0, velocity.y) # if the velocity in x gets close enough to zero, we set it to zero

func _apply_gravity():#define a new function (to apply gravity)
	if not is_on_floor():#if the character is not on a surface(the floor)
		velocity += gravity#the velocity variable is increased by the value of the gravity variable

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_get_input()#call the get input function
	_limit_speed()#call the limit speed function
	_apply_friction()#call the apply friction function
	_apply_gravity()#call the apply gravity function

	move_and_slide() #call the move and slide function
	pass

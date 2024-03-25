extends CharacterBody2D

@export var player_name = "n00b"
@export var speed = 250
@export var friction = 0.2

func _ready():
	pass

func _physics_process(delta):
	#movement section ------------------------------------------------------
	
	var movement = Vector2()
	movement.x = Input.get_action_strength("m_right") - Input.get_action_strength("m_left")
	movement.y = Input.get_action_strength("m_down") - Input.get_action_strength("m_up")
	
	if movement.x >= 1 or movement.y >= 1 or movement.x >= -1 or movement.y >= -1:
		movement = movement.normalized()
	
	var frictioned_vel = movement * speed
	
	velocity += (frictioned_vel - velocity) * friction #TODO add sprint option
	move_and_slide()
	print(movement)
	
	#movement section --------------------------------------------------------

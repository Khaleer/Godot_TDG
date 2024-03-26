extends CharacterBody2D

@export var player_name = "n00b"
@export var speed = 250
@export var friction = 0.2

@export var camera_movement_friction = 0
@export var camera_x_movement = 1.5
@export var camera_y_movement = 2.5

func _ready():
	pass

func _physics_process(delta):
	#movement section ------------------------------------------------------
	
	var movement = Vector2()
	movement.x = Input.get_action_strength("m_right") - Input.get_action_strength("m_left")
	movement.y = Input.get_action_strength("m_down") - Input.get_action_strength("m_up")
	
	if movement.x >= 1 or movement.y >= 1 or movement.x >= -1 or movement.y >= -1:
		movement = movement.normalized()
	
	var frictioned_vel = movement * speed * delta
	
	velocity += (frictioned_vel - velocity) * friction #TODO add sprint option
	move_and_collide(velocity)
	print(movement)
	print(self.position)

func _process(delta):
	camera_movement(delta)

func camera_movement(delta):
	#camera movement section --------------------------------------------------------
	#camera movement variables-----------------------------------------------
	var cam = $Camera2D
	var ded_zone = $CameraLimit/CollisionShape2D.shape
	var ded_zone_pos = $CameraLimit/CollisionShape2D
	var p_position = self.position
	var mouse_position = get_local_mouse_position() #get mouse pos
	var cam_position = cam.get_screen_center_position() # get screen pos
	
	cam.set_limit_smoothing_enabled(true)

	
	cam.limit_top = ded_zone_pos.global_position.y + ded_zone.get_rect().position.y * camera_y_movement
	cam.limit_bottom = ded_zone_pos.global_position.y - ded_zone.get_rect().position.y * camera_y_movement
	cam.limit_right = ded_zone_pos.global_position.x - ded_zone.get_rect().position.x * camera_x_movement
	cam.limit_left = ded_zone_pos.global_position.x + ded_zone.get_rect().position.x * camera_x_movement
	
	cam.set_position(mouse_position)
	cam_position = cam_position.normalized() * delta * camera_movement_friction
	
	#add zoom
	

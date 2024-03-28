extends CharacterBody2D

@export var player_name = "n00b"
@export var speed = 250
@export var friction = 0.2

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

func _process(delta):
	camera_movement(delta)
	check_stats_overwiev()

func camera_movement(delta):
	#camera movement section --------------------------------------------------------
	#camera movement variables-----------------------------------------------
	var cam = $Camera2D
	var ded_zone = $CameraLimit/CollisionShape2D.shape
	var ded_zone_pos = $CameraLimit/CollisionShape2D
	var p_position = self.position
	var mouse_position = get_global_mouse_position() #get mouse pos
	var cam_position = cam.get_screen_center_position() # get screen pos
	
	cam.set_limit_smoothing_enabled(true)

	
	cam.limit_top = ded_zone_pos.global_position.y + ded_zone.get_rect().position.y * camera_y_movement
	cam.limit_bottom = ded_zone_pos.global_position.y - ded_zone.get_rect().position.y * camera_y_movement
	cam.limit_right = ded_zone_pos.global_position.x - ded_zone.get_rect().position.x * camera_x_movement
	cam.limit_left = ded_zone_pos.global_position.x + ded_zone.get_rect().position.x * camera_x_movement
	
	if get_velocity() != Vector2(0,0):
		cam.position = Vector2(0,0)
	else:
		cam.set_position(mouse_position)
		
	if Input.is_action_pressed("right_mouse"):
		cam.set_position(mouse_position)
		cam_position = cam_position.normalized() * delta
	else:
		cam.position = Vector2(0,0)
	
	#add zoom
	var zoom = cam.zoom
	var zoom_speed = Vector2(-5,-5) * delta
	var min_zoom = $Camera2D.zoom - zoom_speed
	var max_zoom = $Camera2D.zoom + zoom_speed
	
	if Input.is_action_just_pressed("Scroll_down") and $Camera2D.zoom >= Vector2(0.5,0.5):
		$Camera2D.set_zoom(max_zoom)
		print(cam.zoom)

	if Input.is_action_just_pressed("Scroll_up") and $Camera2D.zoom <= Vector2(1.5,1.5):
		$Camera2D.set_zoom(min_zoom)
		print(cam.zoom)
	if zoom != Vector2(1,1) :
		p_position == cam_position * delta
		
	if zoom >= Vector2(1.25,1.25):
		cam.set_position($Sprite2D.position)

func check_stats_overwiev():
	if Input.is_action_just_pressed("check_overwiev"):
		print(PlayerStats.multiplic())

extends CharacterBody2D

@export var player_name = "n00b"
@export var speed = 100
@export var angular_speed := 5.0
@export var friction = 1.0
@export var health = 100
@export var stamina = 100
@export var hunger = 10.0
@export var thrist = 10.0

func _ready():
	pass

func _physics_process(delta):
	var direction = Vector2(Input.get_action_strength("m_right") - Input.get_action_strength("m_left"), Input.get_action_strength("m_down") - Input.get_action_strength("m_up"))
	if direction >= 1.0:
		direction = direction.normalized()
	var movement = direction * speed
	move_and_slide()

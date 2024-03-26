extends Node2D

@export_file var next_scene = "res://Scenes/testing_ground.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().change_scene_to_file(next_scene)
	#ResourceLoader.load_threaded_request(next_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

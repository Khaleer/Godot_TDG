extends Node2D

@export var popup_text = "Type text here"#str("Type text here")

func _ready():
	$RichTextLabel.hide()
	$RichTextLabel.text = popup_text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		$RichTextLabel.show()


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		$RichTextLabel.hide()

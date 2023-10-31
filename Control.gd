extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_value(value):
	$TextureProgressBar.value = value
	if value < 100:
		show()
	else:
		hide()

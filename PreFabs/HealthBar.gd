extends Control

func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_value(value):
	$HealthBar.value = value
	if value < 100:
		show()
	else:
		#hide()
		pass

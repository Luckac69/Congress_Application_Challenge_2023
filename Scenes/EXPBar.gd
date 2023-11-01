extends TextureProgressBar

@export var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	player.exp_changed.connect(update)
	update()

func update():
	value = player.expamount * 100 / player.maxexp

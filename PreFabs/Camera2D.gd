extends Camera2D

@export var randomStrength: float = 30.0
@export var shakeFade: float = 5.0

var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0

func applyshake():
	shake_strength = randomStrength
	


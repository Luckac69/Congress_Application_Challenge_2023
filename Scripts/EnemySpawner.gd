extends Marker2D

signal spawned(spawn)

@export var mintime : float = 1
@export var maxtime : float = 3
@export var spawnlings: Array 


func _ready():
	$Timer.start()
	print("TimerMoment")

func spawn():
	randomize()
	var randomspawn = spawnlings[randi_range(0,spawnlings.size()-1)]
	var spawnling = randomspawn.instantiate()
	
	spawnling.global_position = position
	add_child(spawnling)

	
	emit_signal("spawned", spawnling)
	return(spawnling)
	
	$Timer.wait_time = randf_range(mintime, maxtime)
	
	
func _on_timer_timeout():


extends Control

@export var mainGameScene : PackedScene



func _on_start_button_button_up():
	get_tree().change_scene_to_file("res://Scenes/World.tscn")
	

func _on_study_button_button_up():
	pass # Replace with function body.


func _on_credit_button_button_up():
	pass # Replace with function body.


func _on_exit_button_button_up():
	get_tree().quit()
	#exits game

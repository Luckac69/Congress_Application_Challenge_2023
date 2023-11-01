extends Control


@export var ResumeButton: Button
@export var ExitLevelButton: Button

func _on_resume_button_button_up():
	Engine.time_scale = 1
	visible = false
	

func _on_exit_button_button_up():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	visible = false
	

extends Control

func _on_start_button_button_up():
	get_tree().change_scene_to_file("res://Scenes/World.tscn")
	

func _on_study_button_button_up():
	get_tree().change_scene_to_file("res://Scenes/study_menu.tscn")


func _on_credit_button_button_up():
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")


func _on_exit_button_button_up():
	get_tree().quit()
	#exits game

extends Control

func _on_create_button_button_up():
	$MenuSound.play()
	get_tree().change_scene_to_file("res://question_create_menu.tscn")


func _on_back_button_button_up():
	$MenuSound.play()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

extends Control


func _on_start_button_button_up():
	pass


func _on_exit_button_button_up():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

extends Control

@export var Question : TextEdit

@export var Answer1 : TextEdit
@export var Answer2 : TextEdit
@export var Answer3 : TextEdit
@export var Answer4 : TextEdit



func _on_create_button_button_up():
	print(Question.text)
	print(Answer1.text)
	print(Answer2.text)
	print(Answer3.text)
	print(Answer4.text)
	
	get_tree().change_scene_to_file("res://Scenes/study_menu.tscn")
	
	


func _on_back_button_button_up():
	get_tree().change_scene_to_file("res://Scenes/study_menu.tscn")

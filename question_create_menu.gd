extends Control

@export var Question : TextEdit
@export var Answer1 : TextEdit
@export var Answer2 : TextEdit
@export var Answer3 : TextEdit
@export var Answer4 : TextEdit
var amount : int = 0


@onready var QuestionsFolder = get_node("Questions")
@onready var questionsdictionary = $"/root/GlobalScript".QuestionDictionary


func _on_create_button_button_up():
	
	var QuestionTable={
		"Question":Question.text,
		"Answer1":Answer1.text,
		"Answer2":Answer2.text,
		"Answer3":Answer3.text,
		"Answer4":Answer4.text
		}
		
	for Questions in questionsdictionary:
		amount = amount + 1
		
	questionsdictionary["Question" + str(amount)] = QuestionTable
	print(questionsdictionary)
	
	get_tree().change_scene_to_file("res://Scenes/study_menu.tscn")

func _on_back_button_button_up():
	get_tree().change_scene_to_file("res://Scenes/study_menu.tscn")

extends Control

@export var Question : TextEdit
@export var Answer1 : TextEdit
@export var Answer2 : TextEdit
@export var Answer3 : TextEdit
@export var Answer4 : TextEdit
@export var	CorrectAnswer : Label
@export var	SliderCorrect : HSlider
var amount : int = 0

@onready var questionsdictionary = $"/root/GlobalScript".QuestionDictinary

func _ready():
	$StudyTheme.play()


func _on_create_button_button_up():
	$MenuSound.play()
	
	var IsAnswer1 = false
	var IsAnswer2 = false
	var IsAnswer3 = false
	var IsAnswer4 = false
	
	var SliderValue = SliderCorrect.value
	
	if SliderValue == 1:
		IsAnswer1 = true
		IsAnswer2 = false
		IsAnswer3 = false
		IsAnswer4 = false
	if SliderValue == 2:
		IsAnswer1 = false
		IsAnswer2 = true
		IsAnswer3 = false
		IsAnswer4 = false
	if SliderValue == 3:
		IsAnswer1 = false
		IsAnswer2 = false
		IsAnswer3 = true
		IsAnswer4 = false
	if SliderValue == 4:
		IsAnswer1 = false
		IsAnswer2 = false
		IsAnswer3 = false
		IsAnswer4 = true

	var QuestionTable={
		"Question": Question.text,
		"Answer1": Answer1.text,
		"Answer2": Answer2.text,
		"Answer3": Answer3.text,
		"Answer4": Answer4.text,
		"Answer1Is": IsAnswer1,
		"Answer2Is": IsAnswer2,
		"Answer3Is": IsAnswer3,
		"Answer4Is": IsAnswer4
		}
		
	for Questions in questionsdictionary:
		amount = amount + 1
		
	questionsdictionary["Question" + str(amount)] = QuestionTable
	print(questionsdictionary)
	
	get_tree().change_scene_to_file("res://Scenes/study_menu.tscn")

func _on_back_button_button_up():
	$MenuSound.play()
	get_tree().change_scene_to_file("res://Scenes/study_menu.tscn")


func _on_h_slider_value_changed(value):
	$MenuSound.play()
	CorrectAnswer.text = "The Correct answer is Set To Answer Choice" + str(SliderCorrect.value)

extends Control

#THESE ARE THE QUESTION BOXES NOT THE ACTUAL QUESTION STRINGS

@onready var Questi = get_node("MarginContainer/VBoxContainer/QuizZone/QuestionBox/QuestionMargin/Label")
@export var Answ1 : Button
@export var Answ2 : Button
@export var Answ3 : Button
@export var Answ4 : Button
@export var AnswerDelay : Timer

@onready var check = get_node("MarginContainer/Response/Check")
@onready var wrong = get_node("MarginContainer/Response/Wrong")

@onready var questionsdictionary = $"/root/GlobalScript".QuestionDictinary
#the player just sent a signal and the gui is now visible
#you must now generate the four answer choices and 1 question
#and pick a random one from the dictionary
var Choice1
var Choice2
var Choice3
var Choice4

var StartTimer = false
var elapsed_time = 0


func _ready():
	$"/root/GlobalScript".popupquestion = self

func questionpopup(placeholder):
	
	var size = questionsdictionary.size()
	var random_key = questionsdictionary.keys()[randi() % size]
	var cardchosen = questionsdictionary[random_key]
	
	Questi.text = str(cardchosen["Question"])
	Answ1.text = str(cardchosen["Answer1"])
	Answ2.text = str(cardchosen["Answer2"])
	Answ3.text = str(cardchosen["Answer3"])
	Answ4.text = str(cardchosen["Answer4"])
	
	Choice1 = cardchosen["Answer1Is"]
	Choice2 = cardchosen["Answer2Is"]
	Choice3 = cardchosen["Answer3Is"]
	Choice4 = cardchosen["Answer4Is"] 
	print(Choice1)
	print(Choice2)
	print(Choice3)
	print(Choice4)


func _on_answer_button_button_up():
	if Choice1 == true:
		$AnswerCorrect.play()
		StartTimer = true
		check.visible = true
		Engine.time_scale = 1
		AnswerDelay.start()
	else:
		$AnswerWrong.play()
		StartTimer = true
		wrong.visible = true
		Engine.time_scale = 1
		AnswerDelay.start()

func _on_answer_button_2_button_up():
	if Choice2 == true:
		$AnswerCorrect.play()
		check.visible = true
		StartTimer = true
		Engine.time_scale = 1
		AnswerDelay.start()
	else:
		$AnswerWrong.play()
		wrong.visible = true
		StartTimer = true
		Engine.time_scale = 1
		AnswerDelay.start()

func _on_answer_button_3_button_up():
	if Choice3 == true:
		$AnswerCorrect.play()
		check.visible = true
		StartTimer = true
		Engine.time_scale = 1
		AnswerDelay.start()
	else:
		$AnswerWrong.play()
		wrong.visible = true
		StartTimer = true
		Engine.time_scale = 1
		AnswerDelay.start()


func _on_answer_button_4_button_up():
	if Choice4 == true:
		$AnswerCorrect.play()
		check.visible = true
		StartTimer = true
		Engine.time_scale = 1
		AnswerDelay.start()
	else:
		$AnswerWrong.play()
		wrong.visible = true
		StartTimer = true
		Engine.time_scale = 1
		AnswerDelay.start()


func _on_answer_delay_timeout():
	check.visible = false
	wrong.visible = false
	visible = false

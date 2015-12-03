
extends Node2D

var move = false
var ini
var label
var label_score

func _ready():
	set_process(true)
	label = get_node("Congratulations")
	label_score = get_node("score")

func _process(delta):
	if (Input.is_action_pressed("ui_accept")):
		move = true
	if(Input.is_action_pressed("ui_cancel")):
		get_tree().quit()
	
	if (move == true and label_score.get_end().y >= 0):
		label.set_pos(Vector2(label.get_pos().x, label.get_pos().y - 2))
		label_score.set_pos(Vector2(label_score.get_pos().x, label_score.get_pos().y - 2))
	
	if (label_score.get_end().y < 0):
		get_tree().change_scene("res://credits.xscn")
	
extends Node

var currentScene = null
var stage = 1


func _ready():
	currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1)
	print ("ready globals")
	
func next_scene():
	if (stage == 1):
		stage += 1
		return load("res://stage-1.xscn")
	elif (stage == 2):
		stage += 1
		return load("res://stage-2.xscn")
	elif (stage == 3):
		stage = 1
		return load("res://stage-3.xscn")
	
extends Node

var currentScene = null
var stage = 1
var file_name = "res://placar"
var score
var placar = File.new()

func _init():
	placar.open(file_name, File.WRITE)
	placar.store_32(0)
	placar.close()

func _ready():
	currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1)
	
func next_scene():
	if (stage == 1):
		return load("res://stage-1.xscn")
	elif (stage == 2):
		return load("res://stage-2.xscn")
	elif (stage == 3):
		return load("res://stage-3.xscn")

func sum_stage():
	stage += 1
	
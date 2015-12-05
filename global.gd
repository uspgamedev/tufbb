
extends Node

var stage = 1
var file_name = "res://placar"
var score
var placar = File.new()

func _init():
	OS.set_window_fullscreen(true)
	placar.open(file_name, File.WRITE)
	placar.store_32(0)
	placar.close()
	
func next_scene():
	if (stage == 1):
		return load("res://stage-1.xscn")
	elif (stage == 2):
		return load("res://stage-2.xscn")
	elif (stage == 3):
		return load("res://stage-3.xscn")
	
func sum_stage():
	stage += 1
	
func current_stage():
	return stage
	
func reset():
	stage = 1
	
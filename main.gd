
extends Node

var bricks
var scene = preload("res://stage-1.xscn")
var node

func _ready():
	set_fixed_process(true)
	
	node = scene.instance()
	add_child(node)
	
func _fixed_process(delta):
	if(Input.is_action_pressed("ui_cancel")):
		get_tree().quit()
	
	#if(Input.is_action_pressed("ui_pause")):
	#	print ("pressed")
	#	if (!get_tree().is_paused()):
	#		get_tree().set_pause(true)
	#	else:
	#		get_tree().set_pause(false)
	#else:
	#	print ("umpressed")
	
func brickHasDied():
	var brick1 = get_tree().get_nodes_in_group("brick_1hit").size()
	var brick2 = get_tree().get_nodes_in_group("brick_2hit").size()
	var brick3 = get_tree().get_nodes_in_group("brick_3hit").size()
	
	bricks = brick1 + 2*brick2 + 3*brick3
	
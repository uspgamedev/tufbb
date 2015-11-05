
extends Node

var bricks
var scene = preload("res://stage-1.xscn")
var node
var points
var file_name = "res://placar"
var score
var placar = File.new()

func _ready():
	set_fixed_process(true)
	
	node = scene.instance()
	add_child(node)
	
	move_child(node, 0)
	
	placar.open(file_name, File.READ)
	score = placar.get_32()
	placar.close()
	
func _fixed_process(delta):
	if(Input.is_action_pressed("ui_cancel")):
		get_tree().quit()
	
	var label = get_node("Label")
	placar.close()
	label.set_text(str("Score: ", score))
	
func brickHasDied(points):
	var brick1 = get_tree().get_nodes_in_group("brick_1hit").size()
	var brick2 = get_tree().get_nodes_in_group("brick_2hit").size()
	var brick3 = get_tree().get_nodes_in_group("brick_3hit").size()
	
	bricks = brick1 + 2*brick2 + 3*brick3
	
	placar.open(file_name, File.WRITE)
	score += points
	placar.store_32(score)
	placar.close()
	
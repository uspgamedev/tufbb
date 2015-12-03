
extends Node

var bricks
var node
var points
var file_name = "res://placar"
var score
var placar = File.new()

func _ready():
	set_process_input(true)
	
	set_fixed_process(true)
	
	var root_children = get_node("/root").get_children()
	var scene = root_children[0].next_scene()
	
	node = scene.instance()
	add_child(node)
	
	move_child(node, 0)
	
	placar.open(file_name, File.READ)
	score = placar.get_32()
	placar.close()
	
	var brick1 = get_tree().get_nodes_in_group("brick_1hit").size()
	var brick2 = get_tree().get_nodes_in_group("brick_2hit").size()
	var brick3 = get_tree().get_nodes_in_group("brick_3hit").size()
	
	bricks = brick1 + 2*brick2 + 3*brick3
	
func _fixed_process(delta):
	
	var label = get_node("Label")
	label.set_text(str("Score: ", score))
	
func _input(event):
	if (event.is_action("ui_teste") and !event.is_pressed()):
		Input.warp_mouse_pos(Vector2(100, 100))
	if (event.is_action("ui_cancel") and !event.is_pressed()):
		var bar = get_node("bar")
		if (!get_tree().is_paused()):
			print ("mouse1 ", get_viewport().get_mouse_pos())
			print ("barra1 ", bar.get_pos())
			get_tree().set_pause(true)
			bar.set_fixed_process(false)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			var stretch = OS.get_video_mode_size().y / get_viewport().get_rect().end.y
			var black = (OS.get_video_mode_size().x - stretch*get_viewport().get_rect().end.x) / 2
			print (stretch)
			get_tree().set_pause(false)
			bar.set_fixed_process(true)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Input.warp_mouse_pos(Vector2(black + stretch*bar.get_pos().x, stretch*bar.get_pos().y))
			print ("mouse2 ", get_viewport().get_mouse_pos())
			print ("barra2 ", bar.get_pos())
			
	
func brickHasDied(points):
	var brick1 = get_tree().get_nodes_in_group("brick_1hit").size()
	var brick2 = get_tree().get_nodes_in_group("brick_2hit").size()
	var brick3 = get_tree().get_nodes_in_group("brick_3hit").size()
	
	var fx = get_node("./SamplePlayer")
	fx.brick_fx()
	
	bricks = brick1 + brick2 + brick3
	
	placar.open(file_name, File.WRITE)
	score += points
	placar.store_32(score)
	placar.close()
	
	var label = get_node("Label")
	label.sinaliza()
	
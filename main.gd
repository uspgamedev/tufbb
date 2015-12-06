
extends Node

var bricks
var node
var points
var file_name = "res://placar"
var score
var placar = File.new()
var stretch
var black
var flag = 1

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
	
	stretch = OS.get_video_mode_size().y / get_viewport().get_rect().end.y
	black = (OS.get_video_mode_size().x - stretch*get_viewport().get_rect().end.x) / 2
	if (black < 0):
		black = 0
	
	var label = get_node("Label")
	label.set_text(str("Score: ", score))
	
	if (flag == 1):
		corrige_mouse()
	flag = 1
	
func corrige_mouse():
	#correcao do mouse saindo da tela:
	
	var bar = get_node("bar")
	
	if (get_viewport().get_mouse_pos().x < get_viewport().get_rect().pos.x + bar.tamanho.x/2):
		Input.warp_mouse_pos(Vector2(get_viewport().get_rect().pos.x + black + stretch*bar.tamanho.x/2, OS.get_video_mode_size().y/2))
	
	if (get_viewport().get_mouse_pos().x > get_viewport().get_rect().end.x - bar.tamanho.x/2):
		Input.warp_mouse_pos(Vector2(OS.get_video_mode_size().x - stretch*bar.tamanho.x/2 - black, OS.get_video_mode_size().y/2))
	
func _input(event):
	if (event.is_action("ui_cancel") and !event.is_pressed()):
		var bar = get_node("bar")
		var bg = get_node("pause_background")
		var resume = get_node("resume")
		var quit = get_node("quit")
		if (!get_tree().is_paused()):
			get_tree().set_pause(true)
			set_fixed_process(false)
			bar.set_fixed_process(false)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			bg.set_opacity(0.5)
			resume.show()
			resume.tween()
			quit.show()
			quit.tween()
		else:
			var bar_pos = bar.get_pos()
			get_tree().set_pause(false)
			set_fixed_process(true)
			bar.set_fixed_process(true)
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			Input.warp_mouse_pos(Vector2(black + stretch*bar_pos.x, stretch*bar_pos.y))
			bar.set_pos(Vector2(black + stretch*bar_pos.x, bar_pos.y))
			flag = 0
			bg.set_opacity(0)
			resume.hide()
			quit.hide()
	
func resume():
	var bar = get_node("bar")
	var bg = get_node("pause_background")
	var bar_pos = bar.get_pos()
	var quit = get_node("quit")
	get_tree().set_pause(false)
	set_fixed_process(true)
	bar.set_fixed_process(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.warp_mouse_pos(Vector2(black + stretch*bar_pos.x, stretch*bar_pos.y))
	bg.set_opacity(0)
	quit.hide()
	
func brickHasDied(points):
	var brick1 = get_tree().get_nodes_in_group("brick_1hit").size()
	var brick2 = get_tree().get_nodes_in_group("brick_2hit").size()
	var brick3 = get_tree().get_nodes_in_group("brick_3hit").size()
	
	bricks = brick1 + brick2 + brick3
	
	placar.open(file_name, File.WRITE)
	score += points
	placar.store_32(score)
	placar.close()
	
	var label = get_node("Label")
	label.sinaliza()
	
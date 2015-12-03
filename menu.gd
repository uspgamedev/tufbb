
extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	set_process(true)

func _process(delta):
	if(Input.is_action_pressed("ui_cancel")):
		get_tree().quit()

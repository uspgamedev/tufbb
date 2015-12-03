
extends Button

var hover = 0

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	if (is_pressed()):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		get_tree().change_scene("res://credits.xscn")
		
	if (is_hovered() and not hover):
		var fx = get_node("../SamplePlayer")
		fx.beep_fx()
		hover = 1 
	elif (not is_hovered()):
		hover = 0
	
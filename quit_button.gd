
extends Button

var hover = 0

func _ready():
	set_fixed_process(true)
	hide()
	
func _fixed_process(delta):
	if (is_pressed()):
		get_tree().quit()
	
	if (is_hovered() and not hover):
		var fx = get_node("../SamplePlayer")
		fx.beep_fx()
		hover = 1 
	elif (not is_hovered()):
		hover = 0
	
func tween():
	var tween = get_node("../Tween")
	
	tween.interpolate_method(self, "set_pos", Vector2(-331, 312), Vector2(226, 312), 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	
	tween.set_repeat(false)
	tween.start()
	
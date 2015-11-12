
extends Button

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	if (is_pressed()):
		get_tree().change_scene("res://credits.xscn")
	



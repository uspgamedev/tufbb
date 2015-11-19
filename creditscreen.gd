
extends Label

var ini

func _ready():
	ini = - (get_end().y - 660)
	set_fixed_process(true)
	
func _fixed_process(delta):
	if(Input.is_action_pressed("ui_cancel")):
		get_tree().quit()
	if (get_pos().y > ini):
		set_pos(Vector2(get_pos().x, get_pos().y - 1))
	if (Input.is_action_pressed("ui_accept")):
		get_tree().change_scene("res://menu.xscn")

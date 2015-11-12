
extends Label

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	if (get_pos().y > -1860):
		set_pos(Vector2(get_pos().x, get_pos().y - 1))
	if (Input.is_action_pressed("ui_accept")):
        get_tree().change_scene("res://menu.xscn")


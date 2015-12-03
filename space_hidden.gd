
extends Label

func _ready():
	set_process(true)

func _process(delta):
	if (Input.is_action_pressed("ui_accept")):
		set_process_input(true)
	
func _input(event):
	queue_free()
	
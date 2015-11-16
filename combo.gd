
extends Label

var r = 1
var g = 1
var b = 1

var color

func _ready():
	set_fixed_process(true)
	set_align(ALIGN_CENTER)
	
func _fixed_process(delta):
	var ball = get_node("../ball")
	if (ball.combo >= 3):
		var t = Theme.new()
		t.set_color("font_color", "Label", next_color(ball.combo))
		self.set_theme(t)
		set_text(str("x", ball.combo, "\nHIT\nCOMBO!"))
	else:
		g = 1
		b = 1
		set_text(str())
	
func next_color (combo):
	if (combo <= 13):
		b = 1 - (combo - 3)*0.1
	elif (combo > 13 and combo <= 23):
		g = 1 - (combo - 13)*0.1
	return Color(r, g, b, 1)
	
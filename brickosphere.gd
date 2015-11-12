extends Sprite

var r1
var r2
var g1
var g2
var b1
var b2
var tempo
var state = {
	trans = Tween.TRANS_LINEAR,
	eases = Tween.EASE_IN,
}

func _ready():
	set_fixed_process(true)
	
	troca_cor(1, 0, 0, 1, 1, 0, 0)
	troca_cor(1, 1, 0, 0, 1, 0, 1)
	troca_cor(0, 1, 0, 0, 1, 1, 2)
	troca_cor(0, 1, 1, 0, 0, 1, 3)
	troca_cor(0, 0, 1, 1, 0, 1, 4)
	troca_cor(1, 0, 1, 1, 0, 0, 5)
	
func troca_cor(r1, g1, b1, r2, g2, b2, tempo):
	var tween = get_node ("Tween")
	
	get_node("color/color-from").set_color(Color(r1, g1, b1, 1))
	get_node("color/color-from").connect("color_changed", self, "on_color_changed")
	
	get_node("color/color-to").set_color(Color(r2, g2, b2, 1))
	get_node("color/color-to").connect("color_changed", self, "on_color_changed")
	
	var color_from = get_node("color/color-from").get_color()
	var color_to = get_node("color/color-to").get_color()
	
	tween.interpolate_method(self, "set_modulate", color_from, color_to, 1, state.trans, state.eases, tempo)
	
	tween.set_repeat(true)
	tween.start()

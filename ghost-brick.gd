
extends StaticBody2D

var life = 1
var state = {
	trans = Tween.TRANS_LINEAR,
	eases = Tween.EASE_IN,
}
var cont = 0
var cont2 = 0
var ini

func _ready():
	set_fixed_process (true)
	add_to_group("brick_1hit")
	
	ini = self.get_pos().x
	
func _fixed_process(delta):
	if (life <= 0):
		cont += 1
		if (cont == 30):
			queue_free()
	else:
		var random = randi() % 500
		if (cont2 == 120):
			aparece()
			cont2 = 0
		elif (random == 0 and cont2 == 0):
			desaparece()
			cont2 = 1
	
	if (cont2 >= 1):
		cont2 = (cont2 + 1) % 121
	
func hurt():
	life -= 1
	
	if (life <= 0):
		get_node("/root/SceneRoot/SceneDefault").brickHasDied(900)
	
	set_layer_mask(2)
	set_collision_mask(2)
	
	var tween = get_node("Tween")
	
	#queda na morte:
	
	tween.interpolate_method(self, "set_pos", self.get_pos(), Vector2(self.get_pos().x, self.get_pos().y + 30), 0.5, state.trans, state.eases)
	
	#fade out:
	
	color_change(Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5)

func desaparece ():
	set_layer_mask(2)
	set_collision_mask(2)
	
	color_change(Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1)

func aparece ():
	set_layer_mask(1)
	set_collision_mask(1)
	
	var linha = ini - randi() % 220
	
	var tween = get_node("Tween")
	
	tween.interpolate_method(self, "set_pos", self.get_pos(), Vector2(linha, self.get_pos().y), 0.00001, state.trans, state.eases)
	
	tween.set_repeat(false)
	tween.start()
	
	color_change(Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1)
	
func color_change (before, after, t):
	var tween = get_node("../Tween")
	var sprite = get_node("ghost-brick")

	get_node("../color/color_from").set_color(before)
	get_node("../color/color_from").connect("color_changed", self, "on_color_changed")
	
	get_node("../color/color_to").set_color(after)
	get_node("../color/color_to").connect("color_changed", self, "on_color_changed")
	
	var color_from = get_node("../color/color_from").get_color()
	var color_to = get_node("../color/color_to").get_color()
	
	tween.interpolate_method(sprite, "set_modulate", color_from, color_to, t, state.trans, state.eases)
	
	tween.set_repeat(false)
	tween.start()
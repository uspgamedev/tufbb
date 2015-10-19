
extends StaticBody2D

var life = 1
var state = {
	trans = Tween.TRANS_LINEAR,
	eases = Tween.EASE_IN,
}
var cont = 0
var cont2 = 0

func _ready():
	set_fixed_process (true)
	
	#falling level:
	
	var tween = get_node("Tween")
	var posicao = get_pos()
	#var random = 0.5 + randf()
	
	#tween.interpolate_method(self, "set_pos", Vector2(posicao.x, posicao.y + 100), self.get_pos(), random, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	
	tween.set_repeat(false)
	tween.start()
	
func _fixed_process(delta):
	if (life <= 0):
		cont += 1
		if (cont == 30):
			queue_free()
	else:
		if (cont2 == 0):
			desaparece()
		if (cont2 == 120):
			aparece()
	
	cont2 = (cont2 + 1) % 300
	
func hurt():
	life -= 1
	
	set_layer_mask(2)
	set_collision_mask(2)
	
	var tween = get_node("Tween")
	
	#queda na morte:
	
	tween.interpolate_method(self, "set_pos", self.get_pos(), Vector2(self.get_pos().x, self.get_pos().y + 30), 0.5, state.trans, state.eases)
	
	
	#fade out:
	
	color_change(Color(1, 1, 1, 1), Color(0, 0, 0, 1), 0.5)

func desaparece ():
	set_layer_mask(2)
	set_collision_mask(2)
	
	color_change(Color(1, 1, 1, 1), Color(0, 0, 0, 1), 1)

func aparece ():
	set_layer_mask(1)
	set_collision_mask(1)
	
	var linha = 40 + randi() % 701
	
	var tween = get_node("Tween")
	var random = randi() % 2
	var vector = [Vector2(linha, 40), Vector2(linha, 340)]
	
	tween.interpolate_method(self, "set_pos", self.get_pos(), vector[random], 0.00001, state.trans, state.eases)
	
	tween.set_repeat(false)
	tween.start()
	
	color_change(Color(0, 0, 0, 1), Color(1, 1, 1, 1), 1)

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

extends StaticBody2D

var images = ["res://Sprites/pink-brick.png"]
var life = 2
var posicao
var tamanho = Vector2 (32, 16)
var state = {
	trans = Tween.TRANS_LINEAR,
	eases = Tween.EASE_IN,
}
var cont = 0
var cont2 = 0
var cont3 = 0
var temp2 = 1

func _ready():
	set_fixed_process (true)
	add_to_group("brick_2hit")
	
	var rect = get_viewport().get_rect()
	posicao = get_pos()
	
func _fixed_process (delta):

	var tween = get_node ("Tween")
	var temp = 1
	
	if (life <= 0):
		cont += 1
		if (cont == 30):
			queue_free()
	else:
		var random = randi() % 100
		if (cont3 == 30*temp2):
			aparece()
			cont3 = 0
		elif (random == 0 and cont3 == 0):
			desaparece()
			cont3 = 1
			temp2 = 2 + randi() % 5
	
	if (cont3 >= 1):
		cont3 = (cont3 + 1) % (30*temp2 + 1)
	
	if (cont2 == 0 and cont3 == 0):
		var posicao = Vector2(self.get_pos().x + (randi()%200)-100, (self.get_pos().y + randi()%200)-100)
		if (posicao.x < 22):
			posicao.x = self.get_pos().x + (randi()%200)
		elif (posicao.x > 772):
			posicao.x = self.get_pos().x - (randi()%200)
		if (posicao.y < 32):
			posicao.y = self.get_pos().y + (randi()%200)
		elif (posicao.y > 502):
			posicao.y = self.get_pos().y - (randi()%200)
		temp = 2 + randi() % 4
		tween.interpolate_method(self, "set_pos", self.get_pos(), posicao, temp, Tween.TRANS_ELASTIC, Tween.EASE_OUT_IN)
		cont2 = 1
	elif (cont3 == 0):
		cont2 = (cont2 + 1) % (temp*60)
	
	tween.set_repeat(false)
	tween.start()
	
func hurt():
	life -= 1
	
	if (life <= 0):
		get_node("/root/SceneRoot/SceneDefault").brickHasDied(2400)
		
		var tween = get_node("Tween")
		
		set_layer_mask(2)
		set_collision_mask(2)
		
		#queda na morte:
		
		tween.interpolate_method(self, "set_pos", self.get_pos(), Vector2(self.get_pos().x, self.get_pos().y + 30), 0.5, state.trans, state.eases)
		
		#fade out:
		
		var sprite = get_node("moving-brick")
		
		color_change(Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5)
		
		tween.set_repeat(false)
		tween.start()
	
	else:
		var texture = ImageTexture.new()
		texture.load (images[life-1])
		
		var changeTexture = get_node("moving-brick")
		
		changeTexture.set_texture(texture)
	
func desaparece ():
	set_layer_mask(2)
	set_collision_mask(2)
	
	color_change(Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5)
	
func aparece ():
	set_layer_mask(1)
	set_collision_mask(1)
	
	var linha = 22 + randi() % 752
	var coluna = 32 + randi() % 472
	
	var tween = get_node("Tween")
	
	tween.interpolate_method(self, "set_pos", self.get_pos(), Vector2(linha, coluna), 0.00001, state.trans, state.eases)
	
	tween.set_repeat(false)
	tween.start()
	
	color_change(Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.5)
	
func color_change (before, after, t):
	var tween = get_node("../Tween")
	var sprite = get_node("moving-brick")

	get_node("../color/color_from").set_color(before)
	get_node("../color/color_from").connect("color_changed", self, "on_color_changed")
	
	get_node("../color/color_to").set_color(after)
	get_node("../color/color_to").connect("color_changed", self, "on_color_changed")
	
	var color_from = get_node("../color/color_from").get_color()
	var color_to = get_node("../color/color_to").get_color()
	
	tween.interpolate_method(sprite, "set_modulate", color_from, color_to, t, state.trans, state.eases)
	
	tween.set_repeat(false)
	tween.start()
	
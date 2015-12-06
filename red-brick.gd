
extends StaticBody2D

var images = ["res://Sprites/green-brick.png", "res://Sprites/yellow-brick.png"]
var life = 3
var state = {
	trans = Tween.TRANS_LINEAR,
	eases = Tween.EASE_IN,
}
var cont = 0

func _ready():
	set_fixed_process(true)
	
	add_to_group("brick_3hit")
	
	#falling level:
	
	var tween = get_node("Tween")
	var posicao = get_pos()
	var random = 0.5 + randf()
	
	tween.interpolate_method(self, "set_pos", Vector2(posicao.x, posicao.y - 100), self.get_pos(), random, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	
	tween.set_repeat(false)
	tween.start()
	
func _fixed_process(delta):
	if (life <= 0):
		cont += 1
		if (cont == 30):
			queue_free()
	
func hurt():
	life -= 1
	
	if (life <= 0):
		get_node("/root/SceneRoot/SceneDefault").brickHasDied(400)
		
		var tween = get_node("Tween")
		
		set_layer_mask(2)
		set_collision_mask(2)
		
		#queda na morte:
		
		tween.interpolate_method(self, "set_pos", self.get_pos(), Vector2(self.get_pos().x, self.get_pos().y + 30), 0.5, state.trans, state.eases)
		
		#fade out:
		
		var sprite = get_node("red-brick")
		
		get_node("color/color_from").set_color(Color(1, 1, 1, 1))
		get_node("color/color_from").connect("color_changed", self, "on_color_changed")
		
		get_node("color/color_to").set_color(Color(1, 1, 1, 0))
		get_node("color/color_to").connect("color_changed", self, "on_color_changed")
		
		var color_from = get_node("color/color_from").get_color()
		var color_to = get_node("color/color_to").get_color()
		
		tween.interpolate_method(sprite, "set_modulate", color_from, color_to, 0.5, state.trans, state.eases)
		
		tween.set_repeat(false)
		tween.start()
	
	else:
		var texture = ImageTexture.new()
		texture.load (images[life-1])
		
		var changeTexture = get_node("red-brick")
		
		changeTexture.set_texture(texture)
		
		#treme quando a bola colide:
		
		var tween = get_node("Tween")
		var posicao = self.get_pos()
		
		tween.interpolate_method(self, "set_pos", Vector2(posicao.x, posicao.y + 10), self.get_pos(), 0.5 , Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		
		tween.set_repeat(false)
		tween.start()
		
		#muda a cor do brick na colisao:
		
		var sprite = get_node("red-brick")
		
		get_node("color/color_from").set_color(Color(1, 1, 1, 1))
		get_node("color/color_from").connect("color_changed", self, "on_color_changed")
		
		get_node("color/color_to").set_color(Color(5, 5, 5, 1))
		get_node("color/color_to").connect("color_changed", self, "on_color_changed")
		
		var color_from = get_node("color/color_from").get_color()
		var color_to = get_node("color/color_to").get_color()
		
		tween.interpolate_method(sprite, "set_modulate", color_from, color_to, 0, state.trans, state.eases)
		tween.interpolate_property(sprite, "modulate", color_to, color_from, 0.5, state.trans, state.eases, 0)
	
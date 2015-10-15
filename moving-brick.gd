
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

func _ready():
	set_fixed_process (true)
	
	#falling level:
	
	var tween = get_node ("Tween")
	
	var rect = get_viewport().get_rect()
	posicao = get_pos()
	
	if (posicao.x) == 0:
		tween.interpolate_method(self, "set_pos", Vector2(tamanho.x / 2, 250), Vector2(rect.end.x - tamanho.x / 2, 250), 4, state.trans, state.eases)
		tween.interpolate_property(self, "transform/pos", Vector2(rect.end.x - tamanho.x / 2, 250), Vector2(tamanho.x / 2, 250), 4, state.trans, state.eases, 4)
		
	else:
		tween.interpolate_method(self, "set_pos", Vector2(rect.end.x - tamanho.x / 2, 300), Vector2(tamanho.x / 2, 300), 4, state.trans, state.eases)
		tween.interpolate_property(self, "transform/pos", Vector2(tamanho.x / 2, 300), Vector2(rect.end.x - tamanho.x / 2, 300), 4, state.trans, state.eases, 4)
	
	tween.set_repeat(true)
	tween.start()
	
func _fixed_process (delta):
	if (life <= 0):
		cont += 1
		if (cont == 30):
			queue_free()
	
func hurt():
	life -= 1
	
	if (life <= 0):
		var tween = get_node("Tween")
		
		set_layer_mask(2)
		set_collision_mask(2)
		
		#queda na morte:
		
		tween.interpolate_method(self, "set_pos", self.get_pos(), Vector2(self.get_pos().x, self.get_pos().y + 30), 0.5, state.trans, state.eases)
		
		#fade out:
		
		var sprite = get_node("moving-brick")
	
		get_node("/root/SceneRoot/color/color_from").set_color(Color(1, 1, 1, 1))
		get_node("/root/SceneRoot/color/color_from").connect("color_changed", self, "on_color_changed")
		
		get_node("/root/SceneRoot/color/color_to").set_color(Color(0, 0, 0, 1))
		get_node("/root/SceneRoot/color/color_to").connect("color_changed", self, "on_color_changed")
		
		var color_from = get_node("/root/SceneRoot/color/color_from").get_color()
		var color_to = get_node("/root/SceneRoot/color/color_to").get_color()
		
		tween.interpolate_method(sprite, "set_modulate", color_from, color_to, 0.5, state.trans, state.eases)
		
		tween.set_repeat(false)
		tween.start()
	
	else:
		var texture = ImageTexture.new()
		texture.load (images[life-1])
		
		var changeTexture = get_node("moving-brick")
		
		changeTexture.set_texture(texture)
	

extends Label

var state = {
	trans = Tween.TRANS_LINEAR,
	eases = Tween.EASE_IN,
}
var posicao

func _ready():
	posicao = self.get_pos()

func sinaliza():
	
	#treme:
	
	var tween = get_node("../Tween")
	
	tween.interpolate_method(self, "set_pos", Vector2(posicao.x, posicao.y + 20), posicao, 0.5 , Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	
	tween.set_repeat(false)
	tween.start()
	
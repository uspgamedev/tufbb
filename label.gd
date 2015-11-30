
extends Label

var state = {
	trans = Tween.TRANS_LINEAR,
	eases = Tween.EASE_IN,
}

func sinaliza():
	
	#treme:
	
	var tween = get_node("../Tween")
	var posicao = self.get_pos()
	
	tween.interpolate_method(self, "set_pos", Vector2(posicao.x, posicao.y + 20), self.get_pos(), 0.5 , Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	
	tween.set_repeat(false)
	tween.start()
	
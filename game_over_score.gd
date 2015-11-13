
extends Label
var file_name = "res://placar"
var score
var tmp
var cont = 0
var placar = File.new()

func _ready():
	placar.open(file_name, File.READ)
	score = placar.get_32()
	placar.close()
	tmp = score
	while (tmp / 10 != 0):
		tmp = tmp / 10
		cont += 1
	
	self.set_pos(Vector2(370 - cont*12, self.get_pos().y))
	
	set_text(str(score))

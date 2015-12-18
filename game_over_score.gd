
extends Label
var file_name = "res://placar"
var score
var placar = File.new()

func _ready():
	placar.open(file_name, File.READ)
	score = placar.get_32()
	placar.close()
	set_text(str(score))

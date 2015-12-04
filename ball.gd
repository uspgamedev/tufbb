
extends RigidBody2D

var posicao
var tamanho = Vector2 (16, 16)
var esquerda
var cima
var baixo
var file_name = "res://placar"
var score
var placar = File.new()
var random
var state = {
	trans = Tween.TRANS_LINEAR,
	eases = Tween.EASE_IN,
}
var combo = 0
var cont = 0
var vel
var cont2 = 0

func _ready():
	set_fixed_process(true)
	
	var random = 200*randf() - 100
	set_linear_velocity(Vector2(random, 250))
	
	placar.open(file_name, File.READ)
	if placar.is_open():
		score = placar.get_32()
		score = 0
	else:
		placar = File.new()
		placar.open(file_name, File.WRITE)
		score = 0
		placar.store_32(score)
	placar.close()
	
func _fixed_process(delta):
	if (get_friction() == 0.1):
		cont2 += 1
		if (cont2 == 120):
			set_friction(0)
	
	var rect = get_viewport().get_rect()
	posicao = get_pos()
	
	#top speed:
	#Victor: 2693 :)
	#Isabela: ~2400
	
	if (posicao.x < rect.pos.x - 30 or posicao.x > rect.end.x + 30):
		get_tree().change_scene("res://home-run.xscn")
	
	esquerda = posicao.x - tamanho.x/2
	cima = posicao.y - tamanho.y/2
	baixo = posicao.y + tamanho.y/2
	
	if (cima > rect.end.y):
		var main = get_node("../")
		placar.open(file_name, File.WRITE)
		main.score *= 0.7 + randf()*0.1
		placar.store_32(main.score)
		placar.close()
		get_tree().change_scene("res://gameover.xscn")
	
	var main = get_node("../")
	
	if (main.bricks <= 1):
		placar.open(file_name, File.READ)
		score = placar.get_32()
		placar.close()
		placar.open(file_name, File.WRITE)
		score += 10000
		placar.store_32(score)
		placar.close()
		get_node("/root/globals").sum_stage()
		if (get_node("/root/globals").current_stage() == 4):
			get_node("/root/globals").reset()
			get_tree().change_scene("res://congratulations.xscn")
		else:
			get_tree().change_scene("res://youwin.xscn")
	
func _colide_com_brick (body):
	
	var tween = get_node ("../Tween")
	
	#muda a cor da bola na colisao:
	
	var sprite = get_node("ball")
	
	get_node("../color/color_from").set_color(Color(1, 1, 1, 1))
	get_node("../color/color_from").connect("color_changed", self, "on_color_changed")
	
	get_node("../color/color_to").set_color(Color(5, 5, 5, 1))
	get_node("../color/color_to").connect("color_changed", self, "on_color_changed")
	
	var color_from = get_node("../color/color_from").get_color()
	var color_to = get_node("../color/color_to").get_color()
	
	tween.interpolate_method(sprite, "set_modulate", color_from, color_to, 0, state.trans, state.eases)
	tween.interpolate_property(sprite, "modulate", color_to, color_from, 0.5, state.trans, state.eases, 0)
	
	#extra-scaling da bola:
	
	tween.interpolate_method(sprite, "set_scale", Vector2(1, 1), Vector2(1.5, 1.5), 0, state.trans, state.eases)
	tween.interpolate_property(sprite, "transform/scale", Vector2(1.5, 1.5), Vector2(1, 1), 0.5, state.trans, state.eases, 0)
	
	var fx = get_node("../SamplePlayer")
	
	fx.ball_fx(combo)
	
	if (body.get_type() != "KinematicBody2D"):
		cont += 1
	print (cont)
	if (body.get_filename() == "res://green-brick.xscn" or body.get_filename() == "res://yellow-brick.xscn" or body.get_filename() == "res://red-brick.xscn"
		or body.get_filename() == "res://moving-brick.xscn" or body.get_filename() == "res://ghost-brick.xscn"):
		combo += 1
		body.hurt()
		var main = get_node("../")
		main.score += combo*100
		
		var label = get_node("../Label")
		label.sinaliza()
		
	elif (body.get_type() == "StaticBody2D" and body.get_filename() != "res://blue-brick.xscn" and body.get_name() != "margin-up"):
		combo = 0
		
	if (body.get_filename() == "res://blue-brick.xscn" and cont >= 10):
		print ("correcao")
		set_friction(0.1)
	
	tween.set_repeat(false)
	tween.start()
	
func _colide_com_barra(body):
	var coef = 10
	var bar = get_node("../bar")
	vel = get_linear_velocity()
	if (baixo < bar.baixo):
		if (body.get_type() == "KinematicBody2D"):
			cont = 0
			if (vel.y < 500):
				if ((vel.x > 0 and bar.deltavel > 0) or (vel.x < 0 and bar.deltavel < 0)):
					set_linear_velocity(Vector2(vel.x + coef*bar.deltavel, -1.2*vel.y))
				else:
					set_linear_velocity(Vector2(vel.x + coef*bar.deltavel, -vel.y))
			else:
				if ((vel.x > 0 and bar.deltavel > 0) or (vel.x < 0 and bar.deltavel < 0)):
					set_linear_velocity(Vector2(vel.x + coef*bar.deltavel, -vel.y))
				else:
					set_linear_velocity(Vector2(vel.x + coef*bar.deltavel, -0.8*vel.y))


extends KinematicBody2D

var posicao
var tamanho = Vector2 (120, 10)
var baixo
var vel = 0
var deltavel = 0

func _ready():
	set_fixed_process(true)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	var tween = get_node("../Tween")
	var posicao = get_pos()
	
	tween.set_repeat(false)
	tween.start()

func _fixed_process(delta):
	var rect = get_viewport().get_rect()
	posicao = get_pos()
	
	baixo = posicao.y + tamanho.y/2
	
	deltavel = get_viewport().get_mouse_pos().x - vel
	
	vel = get_viewport().get_mouse_pos().x
	
	#movimento pelo mouse:
	
	if (get_viewport().get_mouse_pos().x > rect.pos.x):
		if (get_viewport().get_mouse_pos().x < rect.end.x):
			set_pos (Vector2 (get_viewport().get_mouse_pos().x, posicao.y))
	
	#correcao da colisao da barra com a margem da tela:
	
	if (get_viewport().get_mouse_pos().x < rect.pos.x + tamanho.x/2):
		set_pos (Vector2 (rect.pos.x + tamanho.x/2, posicao.y))
	
	if (get_viewport().get_mouse_pos().x > rect.end.x - tamanho.x/2):
		set_pos (Vector2 (rect.end.x - tamanho.x/2, posicao.y))
	
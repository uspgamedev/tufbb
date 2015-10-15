
extends Node

func _ready():
	set_fixed_process(true)
	
	#print(self.get_children())
	
	#green - [Node:552]
	#yellow - [Node:643]
	#red - [Node:710]
	#moving - [Node:735]
	#tween - [RigidBody2D:742]
	
	#numero de bricks = 62
	#cada brick: 3 filhos (sprite, hitbox, tween)
	#62 * 3 = 186
	
	#cada cena: 1 SceneRoot
	#4 cenas: 186 + 4 = 190
	
	#(742 - 552) = 190 

func _fixed_process(delta):
	if(Input.is_action_pressed("ui_cancel")):
		get_tree().quit()

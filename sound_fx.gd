
extends SamplePlayer

func ball_fx():
	var fx = play ("ball_fx")
	set_volume(fx, 0.3)

func brick_fx():
	var fx = play ("brick_fx")
	set_volume(fx, 0.5)
	
func beep_fx():
	var fx = play ("beep_fx")
	set_volume(fx, 0.5)
	
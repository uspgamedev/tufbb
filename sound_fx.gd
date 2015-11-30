
extends SamplePlayer

func ball_fx(combo):
	var fx = play ("ball_fx")
	set_volume(fx, 0.2)
	set_pitch_scale(fx, 1)
	
func brick_fx():
	var fx = play ("brick_fx")
	set_volume(fx, 0.5)
	
func beep_fx():
	var fx = play ("beep_fx")
	set_volume(fx, 0.5)
	

extends SamplePlayer

func ball_fx(combo):
	var fx = play ("ball_fx")
	set_volume(fx, 0.25)
	set_pitch_scale(fx, 1 - max((12 - combo), -12)*0.05946)
	
func beep_fx():
	var fx = play ("beep_fx")
	set_volume(fx, 0.5)
	
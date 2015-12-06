
extends SamplePlayer

var pitch
var pot

func ball_fx(combo):
	var fx = play ("ball_fx")
	set_volume(fx, 0.25)
	pot = float(min(combo - 12, 12)) / 12
	pitch = pow(2, pot)
	set_pitch_scale(fx, pitch)
	
func beep_fx():
	var fx = play ("beep_fx")
	set_volume(fx, 0.5)
	
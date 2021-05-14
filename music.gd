extends AudioStreamPlayer2D

func _ready():
	var audio = AudioStreamPlayer.new()
	self.add_child(audio)
	audio.stream = load("res://Improved Game/dSound/dsong.wav")
	audio.play()

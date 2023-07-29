extends Node2D


var sound_collection:= {}



func _ready() -> void:
	var sound_resources = [
		["treasure" , load("res://sound/coin.wav") ],
		["guard_radios", load("res://sound/radio_chatter2.wav")],
		["guard_whistle", load("res://sound/whistle.wav")],
		["pop", load("res://sound/pop.wav")],
		["victory", load("res://sound/victory.wav")]
	]
	
	for sound_pair in sound_resources:
		var player = AudioStreamPlayer.new()
		add_child(player)
		player.stream = sound_pair[1]
		sound_collection[sound_pair[0]] = player
		
	

func play_sound(sound:String) ->void:
	if sound_collection.has(sound):
		sound_collection[sound].play()
		
		

			
	

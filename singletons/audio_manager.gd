extends Node2D



var sound_collection:= {}



func _ready() -> void:
	var sound_resources = [
		["treasure" , load("res://sound/coin.wav") ],
		

	]
	
	for sound_pair in sound_resources:
		var player = AudioStreamPlayer.new()
		player.stream = sound_pair[1]
		sound_collection[sound_pair[0]] = player
		
	

func play_sound(sound:String) ->void:
	if sound_collection.has(sound):
		sound_collection["sound"].play()
		
		

			
	

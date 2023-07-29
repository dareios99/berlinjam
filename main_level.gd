extends Node2D

var STEP_DURATION = 0.35
@onready var person = $"person"

var timeAccum = 0.0

func _process(delta):
	timeAccum += delta
	while timeAccum > STEP_DURATION:
		person.finishStep()
		timeAccum -= STEP_DURATION
		
	var progress = timeAccum / STEP_DURATION
	progress = progress * progress * (3.0 - 2.0 * progress);
		
	person.moveToCurrentTarget(progress)

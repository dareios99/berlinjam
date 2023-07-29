extends Node2D

var STEP_DURATION = 0.35
@onready var guards = $"guards"
@onready var criminals = $"criminals"

var timeAccum = 0.0

func _process(delta):
	var allActors: Array[Node] = []
	allActors.append_array(guards.get_children())
	allActors.append_array(criminals.get_children())
	timeAccum += delta
	while timeAccum > STEP_DURATION:
		for actor in allActors:
			actor.finishStep()
			
			actor.evaluateNext()
		timeAccum -= STEP_DURATION
		
	var progress = timeAccum / STEP_DURATION
	progress = progress * progress * (3.0 - 2.0 * progress);
		
	for actor in allActors:
		actor.moveToCurrentTarget(progress)

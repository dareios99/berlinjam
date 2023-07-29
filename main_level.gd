extends Node2D

var STEP_DURATION = 0.35
@onready var guards = $"guards"
@onready var criminals = $"criminals"

const GUARD = preload("res://guard.tscn")
const CRIMINAL = preload("res://criminal.tscn")


var timeAccum = 0.0

func _ready() -> void:
	set_physics_process(false)
	start_game()
	

func start_game() -> void:
	var i = 0
	for guard in $guard_spawn_points.get_children():
		var guardu = GUARD.instantiate()
		guardu.current_waypoint = i * 3
		guardu.global_position = guard.global_position
		$guards.add_child(guardu)
		i += 1
	
	for crimin in $criminal_spawn_points.get_children():
		var crim = CRIMINAL.instantiate()
		crim.global_position = crim.global_position
		$criminals.add_child(crim)
	
	set_physics_process(true)
	




func _physics_process(delta: float) -> void:
	var allActors: Array[Node] = []
	allActors.append_array(guards.get_children())
	allActors.append_array(criminals.get_children())
	timeAccum += delta
	while timeAccum > STEP_DURATION:
		for actor in allActors:
			actor.finishStep()
		for actor in allActors:
			actor.evaluateNext()
		timeAccum -= STEP_DURATION
		
	var progress = timeAccum / STEP_DURATION
	progress = progress * progress * (3.0 - 2.0 * progress);
		
	for actor in allActors:
		actor.moveToCurrentTarget(progress)

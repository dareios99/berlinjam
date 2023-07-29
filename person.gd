class_name Person
extends CharacterBody2D

#@onready var treasure_container = $"../treasure"
@onready var criminals_container = $"../../criminals"
@onready var waypoints_container = $"../../waypoints"
@onready var tileMap = $"../../map/TileMap"

var path: PackedVector2Array;

enum GuardState { IDLE, PATROLLING, FOLLOWING}
var guard_state := GuardState.IDLE
var target

var check_for_criminals_iterator:= 0
var current_waypoint := 0

var currentPointAlongPath = 0;
var reachedGoal = false

func _ready() -> void:
	path = tileMap.calculatePath(tileMap.getClosestGridPoint(position), tileMap.getClosestGridPoint(Vector2(0, 750)))

func finishStep():
	if reachedGoal:
		return
	currentPointAlongPath += 1
	position = path[currentPointAlongPath]
	if currentPointAlongPath == path.size() - 1:
		reachedGoal = true
		
func moveToCurrentTarget(progress):
	if reachedGoal:
		return
	var move = path[currentPointAlongPath + 1] - path[currentPointAlongPath] 
	position = path[currentPointAlongPath] + move * progress
	
func evaluateNext():
	check_for_criminals_iterator += 1
	
	if guard_state == GuardState.IDLE or check_for_criminals_iterator >= 30:
		check_for_criminals_iterator = 0
		_look_for_criminals()
	
	if guard_state == GuardState.PATROLLING:
		_patrol()
			
	if guard_state == GuardState.FOLLOWING:
		# Follow the criminal
		pass
	
func _look_for_criminals() -> void:
	for criminal in criminals_container.get_children():
		if _check_line_of_sight(criminal):
			guard_state = GuardState.FOLLOWING
			target = criminal
			return
	guard_state = GuardState.PATROLLING

func _patrol() -> void:
	# Find the next waypoint and follow it
	var possible_waypoints:Array = waypoints_container.get_children()
	
	if current_waypoint > (possible_waypoints.size() - 1 ):
		current_waypoint = 0
	
	var next_movement_target:Vector2 = possible_waypoints[current_waypoint].global_position
	# Do the movement logic
	
func _process(delta):
	pass

func waypoint_reached(waypoint:Area2D) -> void:
	if guard_state == GuardState.PATROLLING or guard_state == GuardState.IDLE:
		var possible_waypoints:Array = waypoints_container.get_children()
		if possible_waypoints[current_waypoint] == waypoint:
			current_waypoint += 1
	

func _debug_input_movement() -> void:
	var move_speed:= 357.0 
	velocity = Vector2.ZERO
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x -= move_speed
	elif Input.is_key_pressed(KEY_RIGHT):
		velocity.x += move_speed
	
	if Input.is_key_pressed(KEY_UP):
		velocity.y -= move_speed
	elif Input.is_key_pressed(KEY_DOWN):
		velocity.y += move_speed
	move_and_slide()


func _check_line_of_sight(with_object:Node2D) -> bool:
	if !is_instance_valid(with_object):
		return false
		
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, with_object.global_position)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	
	if result.is_empty():
		return false
	
	return true


func receive_treasure(treasure:String) -> void:
	match treasure:
		"gold":
			pass
		"diamond":
			pass
		"chest":
			pass

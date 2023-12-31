class_name Criminal
extends CharacterBody2D


@onready var treasures_container = $"../../treasure"
@onready var tileMap = $"../../map/TileMap"

enum CriminalState { IDLE, SEARCHING, FOLLOWING, ESCAPING}
var criminal_state := CriminalState.IDLE
var target

var check_for_criminals_iterator:= 0

var path: PackedVector2Array;
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
	rotation = move.angle() + PI / 2.0
	$Sprite2D.look_at(path[currentPointAlongPath] + move * progress)
	$Sprite2D.rotate(PI/2)
	position = path[currentPointAlongPath] + move * progress

func evaluateNext():
	
	if criminal_state == CriminalState.IDLE or check_for_criminals_iterator >= 30:
		check_for_criminals_iterator = 0
		_look_for_treasure()
	
	if criminal_state == CriminalState.SEARCHING:
#		_patrol()
		pass
			
	if criminal_state == CriminalState.FOLLOWING:
		# Follow the criminal
		pass

	_debug_input_movement()

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


func _look_for_treasure() -> void:
	for treasure in treasures_container.get_children():
		if _check_line_of_sight(treasure):
			criminal_state = CriminalState.FOLLOWING
			target = treasure
			return
	criminal_state = CriminalState.SEARCHING
	
	
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

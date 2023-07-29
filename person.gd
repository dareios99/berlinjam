extends CharacterBody2D

@onready var treasure_container = $"../treasure"
@onready var tileMap = $"../map/TileMap"

var path: PackedVector2Array;

func _ready() -> void:
	path = tileMap.calculatePath(tileMap.getClosestGridPoint(position), tileMap.getClosestGridPoint(Vector2(0, 750)))
	
var current = 0;
var reachedGoal = false

func finishStep():
	current += 1
	if current == path.size() - 1:
		reachedGoal = true
	
func moveToCurrentTarget(progress):
	if reachedGoal:
		return
	var move = path[current + 1] - path[current] 
	position = path[current] + move * progress

func _process(delta):
	pass

func _physics_process(delta):
	var target:Node2D
	for diamond in treasure_container.get_children():
		if _check_line_of_sight(diamond):
			pass
			#print("Found " + str(diamond.name))



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

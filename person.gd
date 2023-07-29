class_name Person
extends CharacterBody2D

@onready var treasure_container = $"../treasure"


func _ready() -> void:
	pass


func _physics_process(delta):
	var target:Node2D
	for diamond in treasure_container.get_children():
		if _check_line_of_sight(diamond):
			print("Found " + str(diamond.name))



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

extends RigidBody2D

var held = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ui_rotate_left"):
		if(held):
			self.rotate(1.5708)
		
	if Input.is_action_just_pressed("ui_rotate_right"):
		if(held):
			self.rotate(-1.5708)
	
	if Input.is_action_just_pressed("ui_left"):
		print("pressed")
		var tilemap = $"../../map/TileMap"
		print(get_global_mouse_position())
		print(tilemap.local_to_map(tilemap.get_local_mouse_position()))
		print(to_global(tilemap.local_to_map(tilemap.get_local_mouse_position())))
		print(self.position)
		if(_isInside()):
			held = true
		


	
	if Input.is_action_just_released("ui_left"):
		print( "released")
		held = false
		var tilemap = $"../../map/TileMap"
		print(get_global_mouse_position())
		print(tilemap.local_to_map(tilemap.get_local_mouse_position()))
		print(to_global(tilemap.local_to_map(tilemap.get_local_mouse_position())))
		print(self.position)
		#self.set_position(to_global(tilemap.local_to_map(tilemap.get_local_mouse_position())))
		#var pos = self.position
		#var tilemap = $"../../map/TileMap"
		#var tile_pos = to_global(tilemap.local_to_map(tilemap.get_local_mouse_position()))
		#print(pos)
		#print(tile_pos)
		#global_transform.origin = tile_pos
		
	if held:
		global_transform.origin = get_global_mouse_position()
	
func _isInside() -> bool:
	if( get_global_mouse_position().x > global_transform.origin.x -($CollisionShape2D.shape.get_size().x /2)&& get_global_mouse_position().x < global_transform.origin.x + ($CollisionShape2D.shape.get_size().x /2) && get_global_mouse_position().y > global_transform.origin.y - ($CollisionShape2D.shape.get_size().y /2) && get_global_mouse_position().y < global_transform.origin.y + ($CollisionShape2D.shape.get_size().y /2)) :
		return true
	return false
	

	
	

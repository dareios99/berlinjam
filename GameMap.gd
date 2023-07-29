extends TileMap

var astar:AStar2D
var width:int;
var height:int;

func getCellId(location: Vector2i):
	return location.y * width + location.x
	
func getGridPositionFromId(id: int):
	return Vector2i(id % width, id / width)
	
func getClosestGridPoint(point: Vector2):
	return getGridPositionFromId(astar.get_closest_point(point))

func calculatePath(start: Vector2i, end: Vector2i):
	return self.astar.get_point_path(getCellId(start), getCellId(end))

# Called when the node enters the scene tree for the first time.
func _ready():
	var usedCells = get_used_cells(0)
	var usedRect = get_used_rect()
	
	print(map_to_local(Vector2i(0,0)))
	
	self.width = usedRect.size.x
	self.height = usedRect.size.y
	
	astar = AStar2D.new()
	astar.reserve_space(width * height)
	
	for cell in usedCells:
		if get_cell_tile_data(0, cell).probability > 0.0:
			self.astar.add_point(getCellId(cell), to_global(map_to_local(cell)))
			
	for cell in usedCells:
		if self.astar.has_point(getCellId(cell)):
			var cellLeft = Vector2i(cell.x - 1, cell.y)
			var cellTop = Vector2i(cell.x, cell.y - 1)
			
			if usedRect.has_point(cellLeft) and self.astar.has_point(getCellId(cellLeft)):
				self.astar.connect_points(getCellId(cell), getCellId(cellLeft))
				
			if usedRect.has_point(cellTop) and self.astar.has_point(getCellId(cellTop)):
				self.astar.connect_points(getCellId(cell), getCellId(cellTop))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

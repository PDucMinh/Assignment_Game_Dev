class_name LevelTileMap extends TileMap
@onready var plant = $"../Plant"
@onready var only_once = true
# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.ChangeTilemapBounds(GetTilemapBounds())

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if only_once:
		for new_plant in plant.new_plants:
			add_sibling(new_plant)
		only_once = false
	pass

func GetTilemapBounds() -> Array[Vector2]:
	var bounds : Array[Vector2] = []
	bounds.append(
		Vector2(get_used_rect().position * rendering_quadrant_size)
	)
	bounds.append( 
		Vector2(get_used_rect().end * rendering_quadrant_size)
	)
	return bounds

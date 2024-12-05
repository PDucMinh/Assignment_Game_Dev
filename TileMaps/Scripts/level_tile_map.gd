class_name LevelTileMap extends TileMap
@onready var plant = $"../Plant"
@onready var normal_tree = $"../NormalTree"
@onready var pine_tree = $"../PineTree"
@onready var slime = $"../Slime"
@onready var only_once = true
@onready var playground = $".."
# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.change_tilemap_bounds(get_tilemap_bounds())

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if only_once:
		for new_plant in plant.new_plants:
			add_sibling(new_plant)
		for new_tree in normal_tree.new_trees:
			add_sibling(new_tree)
		for new_tree in pine_tree.new_trees:
			add_sibling(new_tree)
		only_once = false
		
	pass

func spawn_new_enemy(time_of_duplication : int) -> void:
	var limit_left = int(-400)
	var limit_top = int(-400)
	var limit_right = int(400)
	var limit_bottom = int(400)
	for i in range(0,time_of_duplication):
		var new_enemy = preload("res://Enemies/Slime/slime.tscn").instantiate()
		new_enemy.position = Vector2(randf_range(limit_left, limit_right), randf_range(limit_bottom, limit_top))
		add_sibling(new_enemy)

func get_tilemap_bounds() -> Array[Vector2]:
	var bounds : Array[Vector2] = []
	bounds.append(
		Vector2(get_used_rect().position * rendering_quadrant_size)
	)
	bounds.append( 
		Vector2(get_used_rect().end * rendering_quadrant_size)
	)
	return bounds

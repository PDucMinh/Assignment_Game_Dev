class_name NormalTree extends Node

@onready var bounds = LevelManager.current_tilemap_bounds
@onready var current_tree = $"."
@onready var new_trees : Array[Node2D] = []
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize_trees_position(10)
	pass # Replace with function body.

func randomize_trees_position(time_of_duplication : int) -> void:
	var limit_left = int(bounds[0].x)
	var limit_top = int(bounds[0].y)
	var limit_right = int(bounds[1].x)
	var limit_bottom = int(bounds[1].y)
	for i in range(0,time_of_duplication):
		var new_tree = current_tree.duplicate()
		new_tree.position = Vector2(randf_range(limit_left, limit_right), randf_range(limit_bottom, limit_top))
		new_trees.append(new_tree)
		print("location of new trees: ", new_tree.position)
	pass


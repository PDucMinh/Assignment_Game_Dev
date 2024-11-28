class_name Plant extends Node

@onready var bounds = LevelManager.current_tilemap_bounds
@onready var current_plant = $"."
@onready var new_plants : Array[Node2D] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	$HitBox.damaged.connect(take_damage)
	randomize_plants_position(2)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# optimize?
func randomize_plants_position(number_plants : int) -> void:
	var limit_left = int(bounds[0].x)
	var limit_top = int(bounds[0].y)
	var limit_right = int(bounds[1].x)
	var limit_bottom = int(bounds[1].y)
	for i in range(0,number_plants):
		var new_plant = current_plant.duplicate()
		new_plant.position = Vector2(randf_range(limit_left, limit_right), randf_range(limit_bottom, limit_top))
		new_plants.append(new_plant)
		print("new_plant.position: ", new_plant.position)
	pass

func take_damage(_damage : int) -> void:
	queue_free()
	pass

extends Node

var current_tilemap_bounds : Array[Vector2]
signal tilemap_bounds_changed(bounds : Array[Vector2])
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func change_tilemap_bounds(bounds : Array[Vector2]) -> void:
	current_tilemap_bounds = bounds
	tilemap_bounds_changed.emit(bounds)

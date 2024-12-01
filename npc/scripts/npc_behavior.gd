@icon("res://npc/icons/npc_behavior.svg")

class_name NPCBehavior extends Node2D

var npc : NPC

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var parent = get_parent()
	if parent is NPC:
		npc = parent as NPC
		# Connect to signal
		npc.do_behavior_enabled.connect(start)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func start() -> void:
	pass

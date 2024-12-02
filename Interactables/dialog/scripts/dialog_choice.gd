@tool
@icon("res://GUI/dialog_system/icons/question_bubble.svg")
class_name DialogChoice extends DialogItem
# Called when the node enters the scene tree for the first time.

var dialog_branches : Array [DialogBranch]
@export var choices : Array[String] = ["Yes", "No"]

func _get_configuration_warnings() -> PackedStringArray:
	# check for dialog items
	if _check_for_dialog_branches() == false:
		return ["Requires at least 2 DialogBranch nodes."]
	else:
		return []

func _ready():
	super()
	for c in get_children():
		if c is DialogBranch:
			dialog_branches.append(c)
	
func _set_editor_display() -> void:
	set_related_text()
	# Set the text based on related DialogText Node
	# Set the dialog choice buttons
	if dialog_branches.size() < 2:
		return
		
	example_dialog.set_dialog_choice(self)
	pass

func set_related_text() -> void:
	var _p = get_parent()
	var _t = _p.get_child(self.get_index() - 1)
	
	if _t is DialogText:
		example_dialog.set_dialog_text(_t)
		example_dialog.content.visible_characters = -1
	pass

func _check_for_dialog_branches() -> bool:
	var _count : int = 0
	for c in get_children():
		if c is DialogBranch:
			_count += 1
			if _count > 1:
				return true
	return false

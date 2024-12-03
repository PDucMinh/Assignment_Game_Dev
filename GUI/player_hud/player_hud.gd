extends CanvasLayer


var hearts : Array[HeartGUI] = []


func _ready():
	for child in $Control/HFlowContainer.get_children() :
		if child is HeartGUI: 
			hearts.append(child)
			child.visible = false
	pass

func update_hp(_hp : int, _max_hp : int) -> void :
	update_max_hp(_max_hp) 
	for val in _max_hp : 
		update_heart(val, _hp)
	pass

func update_heart(_index : int , _hp :  int) -> void :
	var _value : int = clampi(_hp - _index * 2, 0, 2)
	hearts[_index].value = _value
	pass
	
func update_max_hp(_max_hp : int) -> void : 
	var _heart_count : int = roundi(_max_hp * 0.5) 
	for val in hearts.size() : 
		if val < _heart_count :
			hearts[val].visible = true
		else :
			hearts[val].visible = false
	pass

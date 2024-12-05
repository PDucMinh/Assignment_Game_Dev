class_name Enemy extends CharacterBody2D

signal direction_changed(new_direction : Vector2)
signal enemy_damaged(hurt_box : HurtBox)
signal enemy_destroyed(hurt_box : HurtBox)

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
@export var hp : int = 3

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var player : Player
var invulnerable : bool = false
@onready var bounds = LevelManager.current_tilemap_bounds
@onready var current_enemy = $"."
@onready var new_enemies : Array[Node2D] = []


@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var hit_box : HitBox = $HitBox
@onready var state_machine : EnemyStateMachine = $EnemyStateMachine

# Called when the node enters the scene tree for the first time.
func _ready():
	#randomize_enemies_position(10)
	state_machine.initialize(self)
	player = PlayerManager.player
	hit_box.damaged.connect(take_damage)

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(_delta):
	move_and_slide()

func set_direction(_new_direction : Vector2) -> bool:
	if (_new_direction == Vector2.ZERO):
		return false
	direction = _new_direction
	var direction_id : int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_direction = DIR_4[direction_id]
	if (new_direction == cardinal_direction):
		return false
	cardinal_direction = new_direction
	direction_changed.emit(new_direction)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func update_animation(state : String) -> void:
	animation_player.play( state + "_" + animation_direction() )
	pass
	
func animation_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
		
func take_damage( hurt_box : HurtBox ) -> void:
	if invulnerable == true:
		return
	hp -= hurt_box.damage
	if hp > 0:
		enemy_damaged.emit(hurt_box)
	else:
		enemy_destroyed.emit(hurt_box)

func randomize_enemies_position(time_of_duplication : int) -> void:
	var limit_left = int(bounds[0].x)
	var limit_top = int(bounds[0].y)
	var limit_right = int(bounds[1].x)
	var limit_bottom = int(bounds[1].y)
	for i in range(0,time_of_duplication):
		var new_enemy = current_enemy.duplicate()
		new_enemy.position = Vector2(randf_range(limit_left, limit_right), randf_range(limit_bottom, limit_top))
		new_enemies.append(new_enemy)
	pass
	

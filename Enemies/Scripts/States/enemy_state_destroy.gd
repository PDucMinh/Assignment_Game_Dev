class_name EnemyStateDestroy extends EnemyState

@export var animation_name : String = "destroy"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")

var _damage_position : Vector2
var _direction : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init() -> void:
	enemy.enemy_destroyed.connect(on_enemy_destroyed)
	pass

## What happens when the player enters this State?
func enter() -> void:
	enemy.invulnerable = true
	#var rand = randi_range(0, 3)
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.set_direction(_direction)	
	enemy.velocity = _direction * -knockback_speed
	enemy.update_animation(animation_name)
	enemy.animation_player.animation_finished.connect(on_animation_finished)
	pass

## What happens when the player enters this State?
func exit() -> void:
	pass

## What happens during the _process update in this State?
func process(_delta : float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null

## What happens during the _physics_process update in this State?
func physics(_delta : float) -> EnemyState:
	return null
	
func on_enemy_destroyed(hurt_box : HurtBox) -> void:
	_damage_position = hurt_box.global_position
	state_machine.change_state(self)

func on_animation_finished(_a : String) -> void:
	#_animation_finished = true
	enemy.queue_free()

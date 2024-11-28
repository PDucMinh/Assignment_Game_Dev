class_name EnemyStateDestroy extends EnemyState

@export var animation_name : String = "destroy"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")


var _direction : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Init() -> void:
	enemy.enemy_destroyed.connect(OnEnemyDestroyed)
	pass

## What happens when the player enters this State?
func Enter() -> void:
	enemy.invulnerable = true
	#var rand = randi_range(0, 3)
	_direction = enemy.global_position.direction_to(enemy.player.global_position)
	enemy.SetDirection(_direction)	
	enemy.velocity = _direction * -knockback_speed
	enemy.UpdateAnimation(animation_name)
	enemy.animation_player.animation_finished.connect(OnAnimationFinished)
	pass

## What happens when the player enters this State?
func Exit() -> void:
	pass

## What happens during the _process update in this State?
func Process(_delta : float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null

## What happens during the _physics_process update in this State?
func Physics(_delta : float) -> EnemyState:
	return null
func OnEnemyDestroyed() -> void:
	state_machine.ChangeState(self)

func OnAnimationFinished(_a : String) -> void:
	#_animation_finished = true
	enemy.queue_free()

class_name EnemyStateStun extends EnemyState

@export var animation_name : String = "stun"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")
@export var next_state : EnemyState

var _damage_position : Vector2
var _direction : Vector2
var _animation_finished : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Init() -> void:
	enemy.enemy_damaged.connect(OnEnemyDamaged)
	pass

## What happens when the player enters this State?
func Enter() -> void:
	enemy.invulnerable = true
	_animation_finished = false 
	#var rand = randi_range(0, 3)
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.SetDirection(_direction)	
	enemy.velocity = _direction * -knockback_speed
	enemy.UpdateAnimation(animation_name)
	enemy.animation_player.animation_finished.connect(OnAnimationFinished)
	pass

## What happens when the player enters this State?
func Exit() -> void:
	enemy.invulnerable = false
	enemy.animation_player.animation_finished.disconnect(OnAnimationFinished)
	pass

## What happens during the _process update in this State?
func Process(_delta : float) -> EnemyState:
	if _animation_finished == true:
		return next_state
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null

## What happens during the _physics_process update in this State?
func Physics(_delta : float) -> EnemyState:
	return null

func OnEnemyDamaged(hurt_box: HurtBox) -> void:
	_damage_position = hurt_box.global_position
	state_machine.ChangeState(self)

func OnAnimationFinished(_a : String) -> void:
	_animation_finished = true

class_name EnemyState extends Node

static var enemy : Enemy
var state_machine : EnemyStateMachine
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Init() -> void:
	pass

## What happens when the player enters this State?
func Enter() -> void:
	pass

## What happens when the player enters this State?
func Exit() -> void:
	pass

## What happens during the _process update in this State?
func Process(_delta : float) -> EnemyState:
	return null

## What happens during the _physics_process update in this State?
func Physics(_delta : float) -> EnemyState:
	return null


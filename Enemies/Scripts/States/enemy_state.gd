class_name EnemyState extends Node

static var enemy : Enemy
var state_machine : EnemyStateMachine
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init() -> void:
	pass

## What happens when the player enters this State?
func enter() -> void:
	pass

## What happens when the player enters this State?
func exit() -> void:
	pass

## What happens during the _process update in this State?
func process(_delta : float) -> EnemyState:
	return null

## What happens during the _physics_process update in this State?
func physics(_delta : float) -> EnemyState:
	return null


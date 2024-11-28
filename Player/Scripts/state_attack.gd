class_name State_Attack extends State

var attacking : bool = false
@export var attack_sound : AudioStream
@export_range(1,20,0.5) var decelerate_speed : float = 5.0
# Stores a reference to the player that this State belongs to.
@onready var walk : State = $"../Walk"
@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_animation_player : AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var idle : State = $"../Idle"
@onready var audio_stream_player : AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var hurt_box : HurtBox = %AttackHurtBox

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

## What happens when the player enters this State?
func enter() -> void:
	player.update_animation("attack")
	attack_animation_player.play("attack_" + player.animation_direction())
	animation_player.animation_finished.connect(end_attack)
	attacking = true
	
	audio_stream_player.stream = attack_sound
	audio_stream_player.pitch_scale = randf_range(0.8, 1.2)
	audio_stream_player.play()
	await get_tree().create_timer(0.075).timeout # A small delay for realistic effect.
	hurt_box.monitoring = true

	pass

## What happens when the player enters this State?
func exit() -> void:
	animation_player.animation_finished.disconnect(end_attack)
	
	attacking = false
	hurt_box.monitoring = false
	pass

## What happens during the _process update in this State?
func process(_delta : float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta 
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

## What happens during the _physics_process update in this State?
func physics(_delta : float) -> State:
	return null

## What happens with input events in this State?
func handle_input(_event: InputEvent) -> State:
	return null

func end_attack(_newAnimationName: String) -> void:
	attacking = false

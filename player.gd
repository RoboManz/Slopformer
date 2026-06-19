class_name Player extends CharacterBody2D

var vspeed
var direction
var SPEED := 0.0
var canDash : bool 
var spawnpoint = Vector2.ZERO
@export var MAXSPEED = 400
@export var JUMP_VELOCITY := -400.0
@export var ACCELERATION : float = 240.0
@onready var sprite = $AnimatedSprite2D


func _ready() -> void:
	spawnpoint = self.global_position

func airControl(delta : float, direction : float) -> void:
	if direction:
		if(abs(velocity.x) < MAXSPEED):
			velocity.x += 2 * ACCELERATION * sign(direction) * delta
	else:
		velocity.x += ACCELERATION * -sign(velocity.x) * delta

func respawn():
	self.global_position = spawnpoint
	velocity = Vector2.ZERO
	vspeed = 0

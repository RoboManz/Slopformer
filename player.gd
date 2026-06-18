class_name Player extends CharacterBody2D


var SPEED := 0.0
@export var MAXSPEED = 400
@export var JUMP_VELOCITY := -400.0
@export var ACCELERATION : float = 240.0
@onready var sprite = $AnimatedSprite2D

func airControl(delta : float, direction : float) -> void:
	if direction:
		if(abs(velocity.x) < MAXSPEED):
			velocity.x += 2 * ACCELERATION * sign(direction) * delta
	else:
		velocity.x += ACCELERATION * -sign(velocity.x) * delta

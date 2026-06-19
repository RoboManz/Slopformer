extends PlayerState

var coyoteTimer 
func enter(previous_state_path: String, data := {}) -> void:
	player.sprite.play("Drop")
	if(previous_state_path == RUNNING or previous_state_path == IDLE):
		coyoteTimer = 0.5
	
func physics_update(delta: float) -> void:
	var direction = Input.get_axis("left", "right")
	coyoteTimer -= delta
	player.velocity += player.get_gravity() * delta
	player.airControl(delta, direction)
	player.move_and_slide()
	
	if player.is_on_floor():
		player.SPEED = abs(player.velocity.x)
		finished.emit(RUNNING)
	elif(coyoteTimer > 0 and Input.is_action_just_pressed("jump")):
		finished.emit(JUMPING)
	elif Input.is_action_just_pressed("drop"):
		finished.emit(DROPPING)
	elif Input.is_action_just_pressed("dash") and player.canDash:
		player.canDash = false
		player.direction = direction
		finished.emit(DASHING)
	

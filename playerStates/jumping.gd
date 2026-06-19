extends PlayerState

var jumpLeniency 
func enter(previous_state_path: String, data := {}) -> void:
	if(previous_state_path != DROPPING and previous_state_path != DASHING):
		player.velocity.y = player.JUMP_VELOCITY
	jumpLeniency = 0
	player.sprite.play("Jump")
	
	
func physics_update(delta: float) -> void:
	player.velocity += player.get_gravity() * delta
	jumpLeniency -= delta
	var direction = Input.get_axis("left", "right")
	player.airControl(delta, direction)
	player.move_and_slide()
	
	if Input.is_action_just_pressed("jump"):
		jumpLeniency = 0.25
	if player.is_on_floor():
		player.SPEED = abs(player.velocity.x)
		if(jumpLeniency >= 0):
			finished.emit(JUMPING)
		else:
			finished.emit(RUNNING)
	elif Input.is_action_just_pressed("dash") and player.canDash:
		player.canDash = false
		player.velocity.x = direction
		finished.emit(DASHING)
	elif Input.is_action_just_pressed("drop"):
		finished.emit(DROPPING)

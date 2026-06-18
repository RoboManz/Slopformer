extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	if(previous_state_path != DROPPING and previous_state_path != DASHING):
		player.velocity.y = player.JUMP_VELOCITY
	player.sprite.play("Jump")
	
func physics_update(delta: float) -> void:
	player.velocity += player.get_gravity() * delta
	var direction = Input.get_axis("left", "right")
	player.airControl(delta, direction)
	player.move_and_slide()
	
	if player.is_on_floor():
		player.SPEED = abs(player.velocity.x)
		finished.emit(RUNNING)
	elif Input.is_action_just_pressed("dash"):
		player.velocity.x = direction
		finished.emit(DASHING)
	elif Input.is_action_just_pressed("drop"):
		finished.emit(DROPPING)

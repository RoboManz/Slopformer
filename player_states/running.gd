extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.sprite.play("Run")
	
func physics_update(delta: float) -> void:
	player.velocity += player.get_gravity() * delta
	var direction = Input.get_axis("left", "right")
	if direction:
		if(sign(player.velocity.x) != sign(direction)):
			player.SPEED = 20
		player.velocity.x = player.SPEED * sign(direction)
		if(player.SPEED < player.MAXSPEED):
			player.SPEED += player.ACCELERATION * delta
		if(sign(direction) < 0):
			player.sprite.flip_h = true
		elif(sign(direction) > 0):
			player.sprite.flip_h = false
	else:
		player.velocity.x += 2 * player.ACCELERATION * -sign(player.velocity.x) * delta
		player.SPEED = abs(player.velocity.x)
		
	if(player.is_on_wall()):
		player.SPEED = 0
		
	print("speed", player.SPEED)
	print("velocity:", player.velocity.x)
	player.move_and_slide()
	
	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif !direction and player.velocity.x == 0:
		finished.emit(IDLE)
	elif Input.is_action_just_pressed("dash"):
		player.velocity.x = direction
		finished.emit(DASHING)

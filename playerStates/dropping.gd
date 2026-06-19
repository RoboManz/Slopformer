extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.canDash = true
	player.sprite.play("SuperDrop")
	player.vspeed = max(0, player.velocity.y)

func physics_update(delta: float) -> void:
	player.velocity += 10 * player.get_gravity() * delta
	player.vspeed += 3 * player.get_gravity().y * delta 
	player.airControl(delta, Input.get_axis('left', 'right'))
	player.move_and_slide()
	
	print("vspeed",player.vspeed)
	if player.is_on_floor():
		player.velocity.y = min(-350 ,-player.vspeed - 100)
		finished.emit(JUMPING)

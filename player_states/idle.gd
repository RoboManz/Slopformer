extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.sprite.play("Idle")

func physics_update(delta: float) -> void:
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
	
	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif Input.is_action_just_pressed("dash"):
		finished.emit(DASHING)
	elif Input.get_axis("left", "right"):
		finished.emit(RUNNING)

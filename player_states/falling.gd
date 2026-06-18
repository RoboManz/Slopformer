extends PlayerState

var timer = 0.1
func enter(previous_state_path: String, data := {}) -> void:
	player.sprite.play("Drop")
	timer = 0.5
	
func physics_update(delta: float) -> void:
	timer -= delta
	player.velocity += player.get_gravity() * delta
	var direction = Input.get_axis("left", "right")
	player.airControl(delta, direction)
	player.move_and_slide()
	
	if(timer > 0 and Input.is_action_just_pressed("jump")):
		finished.emit(JUMPING)
	
	if player.is_on_floor():
		player.SPEED = abs(player.velocity.x)
		finished.emit(RUNNING)
	elif Input.is_action_just_pressed("drop"):
		finished.emit(DROPPING)
	

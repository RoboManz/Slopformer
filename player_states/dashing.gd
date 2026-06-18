extends PlayerState

var timer

func enter(previous_state_path: String, data := {}) -> void:
	player.sprite.play("Explode")
	player.velocity.y = 0
	player.velocity.x = 1000 * sign(player.velocity.x)
	timer = 0.25


func physics_update(delta: float) -> void:
	timer -= delta
	player.move_and_slide()
	
	if Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	if Input.is_action_just_pressed("drop"):
		finished.emit(DROPPING)
	if(timer <= 0):
		player.SPEED = player.MAXSPEED * 0.5
		player.velocity.x = player.SPEED * sign(player.velocity.x)
		if player.is_on_floor():
			finished.emit(RUNNING)
		else:
			finished.emit(FALLING)

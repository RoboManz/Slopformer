extends PlayerState

var timer
var direction
func enter(previous_state_path: String, data := {}) -> void:
	player.sprite.play("Explode")
	direction = sign(player.velocity.x)
	player.velocity.y = 0
	player.velocity.x = 1000 * player.direction
	timer = 0.25


func physics_update(delta: float) -> void:
	timer -= delta
	direction = Input.get_axis("left", "right")
	player.move_and_slide()
	
	if Input.is_action_just_pressed("drop"):
		finished.emit(DROPPING)
		
	if(sign(direction) == -sign(player.velocity.x) and direction):
		player.velocity.x = 0
		finished.emit(JUMPING)
		
	if player.is_on_wall():
		player.canDash = true
		player.velocity = Vector2(-200 * direction, -400)
		finished.emit(JUMPING)
	elif(timer <= 0):
		player.SPEED = player.MAXSPEED * 0.5
		player.velocity.x = player.SPEED * sign(player.velocity.x)
		if player.is_on_floor():
			finished.emit(RUNNING)
		else:
			finished.emit(JUMPING)

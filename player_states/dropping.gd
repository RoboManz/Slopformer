extends PlayerState

var vspeed
func enter(previous_state_path: String, data := {}) -> void:
	player.sprite.play("SuperDrop")
	vspeed = 0

func physics_update(delta: float) -> void:
	player.velocity += 10 * player.get_gravity() * delta
	vspeed += 3 * player.get_gravity().y * delta 
	player.airControl(delta, Input.get_axis('left', 'right'))
	player.move_and_slide()
	
	print("vspeed",vspeed)
	if player.is_on_floor():
		player.velocity.y = -vspeed - 100
		finished.emit(JUMPING)

extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = SPEED * sign(direction)
		if(sign(direction) < 0):
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("Run")
	else:
		velocity.x -= 300 * delta * sign(velocity.x)
		
	velocity += get_gravity() * delta
	
	if(Input.is_action_just_pressed("jump")):
		$AnimatedSprite2D.play("Jump")
		velocity.y =  JUMP_VELOCITY
		
	move_and_slide()

extends KinematicBody2D

const ACC = 350
const SPD_MULTI = 1
const FRIC = 350
const MAX_SPEED = 125
const GRAV = 10
const JUMP_POWER = 275

var V = Vector2.ZERO


func movement(d):
	var IV = Vector2.ZERO
	IV.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	IV = IV.normalized()
	if IV != Vector2.ZERO:
		V = V.move_toward(IV * MAX_SPEED, ACC * d)
	else: 
		V = V.move_toward(Vector2.ZERO, FRIC * d)
	V = move_and_slide(SPD_MULTI * V)

func _process(delta):
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		V.y -= JUMP_POWER
	movement(delta)
	V.y += GRAV

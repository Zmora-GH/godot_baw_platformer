extends KinematicBody2D

const SOME_VALUE = Vector2(0, -1)
const SPEEDX = 20
const MAX_SPEED = 100
const YPOWER = 220
const YGRAV = 10

onready var ap = $AnimationPlayer
var motion = Vector2()

var runing = false

func movement(d):
	motion.y += YGRAV
	
	if Input.is_action_pressed('ui_right'):
		motion.x += SPEEDX
		runing = true
		$Sprite.flip_h = false
		motion.x = min(motion.x, MAX_SPEED)
	elif Input.is_action_pressed('ui_left'):
		$Sprite.flip_h = true
		runing = true
		motion.x -= SPEEDX
		motion.x = max(motion.x, -MAX_SPEED)
	else:
		motion.x = 0
		runing = false
	
	if is_on_floor():
		ap.play("idle") if not runing else ap.play("Run")
		if Input.is_action_pressed('ui_jump'):
			motion.y -= YPOWER
	else:
		 ap.play("fall")

	motion = move_and_slide(motion, SOME_VALUE)

func _physics_process(delta):
	movement(delta)

extends CharacterBody2D

@export var gravity = 1
@export var jump_power = 1

@onready var sprite = $AnimatedSprite2D
@onready var jump_sound = $JumpSound

var active = true # boolean
var jump_remaining = 2 #2 means double jump
var was_jumping = false
var jump_pitch = 1.0

func _ready():
	print("hello world")                     

func _physics_process(delta):
	velocity.y += gravity * delta

	if active:
		#handle jumping
		
		if was_jumping and is_on_floor ():
			was_jumping = false
			jump_remaining = 2
			sprite.play("run")
			jump_pitch = 1.0
	
		
		if Input.is_action_just_pressed("jump") and jump_remaining > 0:
			jump_remaining -= 1
			was_jumping = true
			velocity.y = - jump_power 
		
			if jump_remaining == 1:
				sprite.play("jump")
			else:
				sprite.play("double jump")
				
			jump_sound.set_pitch_scale(jump_pitch)
			jump_sound.play()
			jump_pitch += 0.2
	
	move_and_slide()

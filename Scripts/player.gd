extends CharacterBody2D

@export var gravity = 1
@export var jump_power = 1

var active = true # boolean
var jump_remaining = 100 #10 means double jumps
var was_jumping = false

func _ready():
	print("hello world")                     

func _physics_process(delta):
	velocity.y += gravity * delta
	
	if active:
		#handle jumping
		if Input.is_action_just_pressed("jump") and jump_remaining > 0:
			jump_remaining -= 1
			was_jumping = true
			velocity.y = - jump_power 
		
	move_and_slide()

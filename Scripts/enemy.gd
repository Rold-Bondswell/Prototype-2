extends CharacterBody2D

@export var movement_speed = 50
@export var jump_sound = 500
@onready var sprite = $AnimatedSprite2D

var active = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	If not active:
		return
	velocity.x = -movement_speed
	Velocity.y += gavity * delta
	

	
	move_slide_()
	
	
func set_active(value):
	active = value
	if active:
		Sprite.play("walk")

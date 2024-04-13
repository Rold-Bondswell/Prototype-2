extends Node2D

@export var world_speed = 250
@export var moving_enviorment: Node2D

var platform = preload("res://Scenes/platform.tscn")
var rng = RandomNumberGenerator.new()
var last_platform_position = Vector2.ZERO
var next_spawn_time = 0

func _ready():
	rng.randomize()
	
func _process(delta):
	#check to see if we need to sp=awn a new platform
	if Time.get_ticks_msec() > next_spawn_time:
		_spawn_next_platform() #refactoring

func _spawn_next_platform ():
	var new_platform = platform.instantiate()
		
		# I am going to add randomly placed platforms
	if last_platform_position == Vector2.ZERO:
		new_platform.position = Vector2(400,0)
	else:
		var x = last_platform_position.x + rng.randi_range(450, 550)
		var y = last_platform_position.y + rng.randi_range(-150, 150)
		new_platform.position = Vector2(x, y)
		
	moving_enviorment.add_child(new_platform)
	last_platform_position = new_platform.position
	next_spawn_time += world_speed

func _physics_process(delta):
	
	moving_enviorment.position.x -= world_speed * delta

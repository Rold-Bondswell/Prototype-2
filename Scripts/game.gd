extends Node2D

@export var world_speed = 250
@export var moving_enviorment: Node2D

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	
func _physics_process(delta):
	
	moving_enviorment.position.x -= world_speed * delta

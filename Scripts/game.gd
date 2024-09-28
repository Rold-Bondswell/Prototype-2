extends Node2D

@export var world_speed = 250
@export var moving_enviorment: Node2D
@export var collectible_pitch_reset_interval = 2000

@onready var collect_sound = $Sounds/CollectSound
@onready var score_label = $HUD/UI/Score
@onready var player = $Player
@onready var play_area = $Enviorment/Static/PlayArea
@onready var game_over_label = $HUD/UI/Score/GameOver

var platform = preload("res://Scenes/platform.tscn")
var platform_collectible_single = preload("res://Scenes/platform_collectible_single.tscn")
var platform_collectible_rainbow = preload("res://Scenes/platform_collectible_rainbow.tscn")
var platform_collectible_row = preload("res://Scenes/platform_collectible_row.tscn")
var platform_enemy = preload("res://Scenes/platform_enemy.tscn")
var rng = RandomNumberGenerator.new()
var last_platform_position = Vector2.ZERO
var next_spawn_time = 0
var score = 0
var collectible_pitch = 1.0
var reset_collectible_pitch_time = 0

func _ready():
	rng.randomize()
	player.player_died.connect(_on_player_died)
	play_area.body_exited.connect(_on_body_exited)
	
func _on_player_died():
	print("on player died called")
	game_over_label.text = game_over_label.text % score
	game_over_label.set_visible(true)
func _on_body_exited():
	print ("You lost")

func _process(delta):
	if not player.active:
		return
	if Time.get_ticks_msec() > reset_collectible_pitch_time:
		collectible_pitch = 1.0
	#check to see if we need to sp=awn a new platform
	if Time.get_ticks_msec() > next_spawn_time:
		_spawn_next_platform() #refactoring
	score_label.text ="Score: %s" % score


func _spawn_next_platform ():
	var available_platforms = [
		platform,
		platform_collectible_single,
		platform_collectible_row,
		platform_collectible_rainbow,
		platform_enemy
		]
	var random_platform = available_platforms.pick_random()
	var new_platform = random_platform.instantiate()
		# I am going to add randomly placed platforms
	if last_platform_position == Vector2.ZERO:
		var y = last_platform_position.y + rng.randi_range(-150, 150)
		new_platform.position = Vector2(400,y)
	else:
		var x = last_platform_position.x + rng.randi_range(450, 550)
		var y = last_platform_position.y + rng.randi_range(-150, 150)
		new_platform.position = Vector2(x, y)
		
	moving_enviorment.add_child(new_platform)
	last_platform_position = new_platform.position
	next_spawn_time += world_speed

func _physics_process(delta):
	if not player.active:
		return
	moving_enviorment.position.x -= world_speed * delta
func add_score(value):
	score += value
	collect_sound.set_pitch_scale(collectible_pitch)
	collect_sound.play()
	collectible_pitch += 0.1
	reset_collectible_pitch_time = Time.get_ticks_msec() + collectible_pitch_reset_interval
	print(score)

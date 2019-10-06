extends Node2D
var arrow = load("res://Misc/1crosshair.png")
var zombie = preload("res://Enemies/Zombie.tscn")
var level = 1
var levelStarted = false
var enemiesToSpawn = 0

var spawners = []

func _ready():
	spawners = [$Spawners/Spawner, $Spawners/Spawner2, $Spawners/Spawner3, $Spawners/Spawner4]
	# Changes only the arrow shape of the cursor
	# This is similar to changing it in the project settings
	Input.set_custom_mouse_cursor(arrow)

func _physics_process(delta):
	
	if levelStarted == false:
		levelStarted = true
		enemiesToSpawn = 5 * level
		spawnEnemies()
	
	if enemiesToSpawn > 0 && $SpawnTimer.is_stopped():
		spawnEnemies()

func spawnEnemies():
	var spawner = choose(spawners)
	var pos = spawner.get_global_position()
	var z = zombie.instance()
	z.set_global_position(pos)
	$Enemies.add_child(z)
	enemiesToSpawn -= 1
	$SpawnTimer.wait_time = choose([1.5, 2, 2.5, 1.25, 2.25])
	$SpawnTimer.start()

func choose(array):
	array.shuffle()
	return array.front()
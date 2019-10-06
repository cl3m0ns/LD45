extends Node2D
var arrow = load("res://Misc/1crosshair.png")
var zombie = preload("res://Enemies/Zombie.tscn")
var shop = preload("res://Misc/Shop.tscn")
var currShop = null
var level = 1
var levelStarted = false
var enemiesToSpawn = 0
var currMoney = 0
var spawners = []
export var round_timer = 15

func _ready():
	spawners = [$Spawners/Spawner, $Spawners/Spawner2, $Spawners/Spawner3, $Spawners/Spawner4]
	$BreakTimer.start()
	# Changes only the arrow shape of the cursor
	# This is similar to changing it in the project settings
	Input.set_custom_mouse_cursor(arrow)
	$Transition.black_go_out()

func _physics_process(delta):
	if currMoney != global.money:
		$UI_Bar/Labels/Money.text = "$" + String(global.money)
	
	if levelStarted == false && $BreakTimer.is_stopped():
		print('start')
		start_round()
		spawnEnemies()
	elif levelStarted && enemiesToSpawn > 0 && $SpawnTimer.is_stopped():
		print('during')
		spawnEnemies()
	elif levelStarted && enemiesToSpawn == 0 && global.enemiesAlive == 0:
		print('end')
		end_round()
	elif $BreakTimer.time_left > 0:
		var timeLeft = String(round($BreakTimer.time_left))
		$UI_Bar/Labels/RoundLabel.text = "Next Round in: " + timeLeft
	
	currMoney = global.money

func start_round():
	if currShop != null:
		currShop = null
	levelStarted = true
	enemiesToSpawn = 5 * level
	global.enemiesAlive = enemiesToSpawn
	$UI_Bar/Labels/RoundLabel.text = "ROUND " + String(level)
	

func spawn_shop():
	currShop = shop.instance()
	add_child(currShop)

func end_round():
	spawn_shop()
	levelStarted = false
	level += 1
	global.rounds_survived = level
	$BreakTimer.wait_time = round_timer
	
	$BreakTimer.start()

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
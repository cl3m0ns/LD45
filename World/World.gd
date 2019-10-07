extends Node2D
var arrow = load("res://Misc/1crosshair.png")
var zombie = preload("res://Enemies/Zombie.tscn")
var shop = preload("res://Misc/Shop.tscn")
var currShop = null
var levelStarted = false
var enemiesToSpawn = 0
var currMoney = 0
var spawners = []
export var round_timer = 15

func _ready():
	if global.MUSIC:
		$Music.play()
	else:
		$Music.stop()
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
		start_round()
		spawnEnemies()
	elif levelStarted && enemiesToSpawn > 0 && $SpawnTimer.is_stopped():
		spawnEnemies()
	elif levelStarted && enemiesToSpawn == 0 && global.enemiesAlive == 0:
		end_round()
	elif $BreakTimer.time_left > 0:
		var timeLeft = String(round($BreakTimer.time_left))
		$UI_Bar/Labels/RoundLabel.text = "Next Round in: " + timeLeft
	
	currMoney = global.money

func start_round():
	if currShop != null:
		currShop._die()
		currShop = null
	levelStarted = true
	enemiesToSpawn = 5 * global.level
	global.enemiesAlive = enemiesToSpawn
	$UI_Bar/Labels/RoundLabel.text = "ROUND " + String(global.level)
	

func spawn_shop():
	currShop = shop.instance()
	add_child(currShop)
	currShop.get_node("PriceLabel").text = "Everything $" + String(10 * global.level) 
	

func end_round():
	spawn_shop()
	levelStarted = false
	global.level += 1
	global.rounds_survived = global.level
	$BreakTimer.wait_time = round_timer
	
	$BreakTimer.start()

func spawnEnemies():
	var spawner = choose(spawners)
	var pos = spawner.get_global_position()
	var z = zombie.instance()
	z.set_global_position(pos)
	$Enemies.add_child(z)
	if global.level <= 2:
		z.hp = 3
	elif global.level > 2 && global.level < 4:
		z.hp = 4
	elif global.level >= 4 && global.level < 6:
		z.hp = 6
	elif global.level >= 6 && global.level < 8:
		z.hp = 8
	elif global.level >= 8 && global.level < 10:
		z.hp = 11
	elif global.level >= 10 && global.level < 12:
		z.hp = 15
	elif global.level >= 12 && global.level < 14:
		z.hp = 18
	else:
		z.hp = 20
	enemiesToSpawn -= 1
	var chooser = choose([1.5, 2, 2.5, 1.25, 2.25])
	if global.level <= 2:
		chooser = choose([1.5, 2, 2.5, 1.25])
	elif global.level > 2 && global.level < 4:
		chooser = choose([1.5, 2, 1.25])
	elif global.level >= 4 && global.level < 6:
		chooser = choose([1.5, 1.75, 1.25])
	elif global.level >= 6 && global.level < 8:
		chooser = choose([1, 1.25, 0.75])
	else:
		chooser = choose([0.75, 0.5, 0.25])
	$SpawnTimer.wait_time = chooser
	$SpawnTimer.start()

func choose(array):
	array.shuffle()
	return array.front()
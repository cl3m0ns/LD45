extends Node

var map_seed = 0
var max_hp = 3
var hp = max_hp
var player_shirt = preload("res://Player/player_shirt.png")
var player_clothed = preload("res://Player/player_clothed.png")
var player = null
var playerSprite = null
var currWeapon = null
var enemiesAlive = 0
var money = 0
var player_damage = 1
var fire_rate = .5
var hasPants = false
var hasShirt = false
var itemPicked = false
var rounds_survived = 0
var SFX = true
var level = 1
var MUSIC = true
var pickupSound = null

func _ready():
	randomize()
	if !map_seed:
		map_seed = randi()
		seed(map_seed)

func check_money():
	return money > 10 * (level-1)

func spend_money():
	money -= 10 * (level-1)

func play_pickup():
	if SFX && pickupSound != null:
		pass
		#pickupSound.play()

func more_damage():
	global.player_damage += 1

func more_fire_rate():
	global.fire_rate -= .025

func update_player_sprite(isShirt):
	if playerSprite == null:
		return
		
	if isShirt:
		playerSprite.set_texture(player_shirt)
	else:
		playerSprite.set_texture(player_clothed)

func reset_stats():
	map_seed = 0
	max_hp = 3
	hp = max_hp
	enemiesAlive = 0
	money = 0
	hasPants = false
	hasShirt = false
	rounds_survived = 0

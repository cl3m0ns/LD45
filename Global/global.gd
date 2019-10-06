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

func _ready():
	randomize()
	if !map_seed:
		map_seed = randi()
		seed(map_seed)
		print("Seed: ", map_seed)

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
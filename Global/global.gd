extends Node

var map_seed = 0
var max_hp = 3
var hp = max_hp
var player_shirt = preload("res://Player/player_shirt.png")
var player_clothed = preload("res://Player/player_clothed.png")
var player = null
var playerSprite = null
var currWeapon = null

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
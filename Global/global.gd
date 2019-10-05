extends Node

var map_seed = 0
var player_shirt = preload("res://Player/player_shirt.png")
var player_clothed = preload("res://Player/player_clothed.png")
var pistol = preload("res://Guns/Gun.tscn")
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

func update_player_gun(gunName):
	match gunName:
		"pistol":
			currWeapon = pistol.instance()
			player.add_child(currWeapon)
			pass
extends Node2D
export var bullet_wait_time = 0.5 #used for firerate
export var bullet_life_time = 1 #used for range
var bullet = preload("res://Bullet/Bullet.tscn")
var isEquipped = false
var prevFlip = null
func _ready():
	$Sprite.frame = 0
	z_as_relative = false

func _physics_process(delta):
	
	
	if prevFlip != global.player.get_node("Sprite").flip_h:
		update_gun_position()
	
	prevFlip = global.player.get_node("Sprite").flip_h
	
	set_gun_rotation()
	
	if isEquipped:
		if Input.is_action_pressed("shooting") && $CanFireTimer.is_stopped():
			fire_bullet()

func set_gun_rotation():
	look_at(get_global_mouse_position())
	
	if get_global_rotation() > 1.5 && get_global_rotation() < 3.5:
		$Sprite.flip_v = true
	elif get_global_rotation() > -3.5 && get_global_rotation() < -1.5:
		$Sprite.flip_v = true
	else:
		$Sprite.flip_v = false

func update_gun_position():
	var myPos = get_global_position()
	var newX = myPos.x
	if global.player.get_node("Sprite").flip_h:
		newX = global.player.get_global_position().x - 4
		z_index = 1
	else:
		z_index = 3
		newX = global.player.get_global_position().x + 5
	
	set_global_position(Vector2(newX, myPos.y))

func fire_bullet():
	$CanFireTimer.wait_time = bullet_wait_time
	$CanFireTimer.start()
	var myBullet = bullet.instance()
	myBullet.moveDir = get_global_mouse_position()
	myBullet.set_global_position(get_position())
	myBullet.start_pos = get_position()
	get_parent().add_child(myBullet)


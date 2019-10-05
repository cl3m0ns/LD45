extends Node2D
export var bullet_wait_time = 0.5 #used for firerate
export var bullet_life_time = 1 #used for range
var bullet = preload("res://Bullet/Bullet.tscn")
var isEquipped = false

func _ready():
	$ArrowAnim/AnimationPlayer.play("idle")
	pass

func _physics_process(delta):
	
	if isEquipped:
		if Input.is_action_pressed("shooting") && $CanFireTimer.is_stopped():
			fire_bullet()

func fire_bullet():
	$CanFireTimer.wait_time = bullet_wait_time
	$CanFireTimer.start()
	var myBullet = bullet.instance()
	myBullet.moveDir = get_global_mouse_position()
	myBullet.set_global_position(get_position())
	myBullet.start_pos = get_position()
	get_parent().add_child(myBullet)
	
func _on_Hitbox_area_entered(area):
	var parent = area.get_parent()
	if parent.get("TYPE") == "PLAYER":
		$ArrowAnim/AnimationPlayer.play("arrow anim")


func _on_Hitbox_area_exited(area):
	var parent = area.get_parent()
	if parent.get("TYPE") == "PLAYER":
		$ArrowAnim/AnimationPlayer.play("idle")

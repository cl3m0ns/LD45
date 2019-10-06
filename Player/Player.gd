extends KinematicBody2D
export (int) var SPEED = 75
var TYPE = "PLAYER"
var moveDir = Vector2.ZERO
enum states { IDLE, MOVE }
var state = states.IDLE
var isFiring = false
var hasWeapon = false
var bullet = preload("res://Bullet/Bullet.tscn")
export var bullet_wait_time = 0.5
var iframes = 0

func _ready():
	global.player = self
	global.playerSprite = $Sprite

func _physics_process(delta):
	get_inputs()
	if moveDir != Vector2.ZERO:
		state = states.MOVE
	else:
		state = states.IDLE
	
	match state:
		states.IDLE:
			$AnimationPlayer.play("idle")
		states.MOVE:
			$AnimationPlayer.play("walk")
			if moveDir.x > 0:
				$Sprite.flip_h = false
			elif moveDir.x < 0:
				$Sprite.flip_h = true
			move()
	
	if isFiring && $CanFireTimer.is_stopped():
		fire_bullet()

	if iframes > 0:
		iframes -= 1
		get_node("Sprite").modulate = Color(10,10,10,10)
	else:
		get_node("Sprite").modulate = Color(1,1,1,1)
	


func fire_bullet():
	$CanFireTimer.wait_time = global.fire_rate
	$CanFireTimer.start()
	var myBullet = bullet.instance()
	myBullet.moveDir = get_global_mouse_position()
	var currPos =get_position()
	myBullet.set_global_position(Vector2(currPos.x, currPos.y-5))
	myBullet.start_pos = get_position()
	get_parent().add_child(myBullet)
	
func get_inputs():
	var move_up = Input.is_action_pressed("move_up")
	var move_down = Input.is_action_pressed("move_down")
	var move_right = Input.is_action_pressed("move_right")
	var move_left = Input.is_action_pressed("move_left")
	
	moveDir.x = -int(move_left) + int(move_right)
	moveDir.y = -int(move_up) + int(move_down)
	
	isFiring  = Input.is_action_pressed("shooting")

func move():
	move_and_slide(moveDir.normalized()*SPEED, Vector2.ZERO)

func do_death():
	global.reset_stats()
	get_tree().change_scene("res://World/World.tscn")

func _on_Hitbox_area_entered(area):
	var body = area.get_parent()
	if body.get("TYPE") == "ENEMY":
		if iframes == 0:
			iframes = 15
			global.hp -= 1
		if global.hp <= 0:
			do_death()
		else:
			#state = KNOCKBACK
			pass
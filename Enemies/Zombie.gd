extends KinematicBody2D
var TYPE = "ENEMY"
var SPEED = choose([50, 40, 55])

var moveDir = Vector2.RIGHT
var oldDir = Vector2.ZERO
var knockDir = Vector2.ZERO

enum {
	NEW_DIR,
	ATTACK,
	MOVE,
	CHASE,
	KNOCKBACK
}
var hp = 4

var dirChoose = [Vector2.RIGHT, Vector2.DOWN, Vector2.UP, Vector2.LEFT, Vector2(1,1), Vector2(-1,-1), Vector2(-1,1), Vector2(1,-1)]
var state = NEW_DIR
var oldState = NEW_DIR
var stateChooser = [MOVE, NEW_DIR]
var deathName = "Zombie"
var iframes = 0
var canDamage = 0
#resources
#var bloodSplatter = preload("res://Explosion/DeathSplatter.tscn")
#var death = preload("res://Enemies/DeadEnemies.tscn")

func _physics_process(delta):
	var distance2Hero = get_global_position().distance_to(global.player.get_global_position())
	if(distance2Hero < 600 && state != KNOCKBACK && state != ATTACK): 
		state = CHASE
	elif oldState == CHASE:
		state = choose(stateChooser)
		
	if iframes > 0:
		iframes -= 1
		get_node("Sprite").modulate = Color(10,10,10,10)
	else:
		get_node("Sprite").modulate = Color(1,1,1,1)
	
	do_state()
	damage_loop()
	oldState = state

func damage_loop():
	if canDamage == 0:
		for body in $Hitbox.get_overlapping_areas():
			if body.get("TYPE") == "PLAYER_HITBOX":
				var player = body.get_parent()
				player.knockDir = player.get_global_position() - get_global_position()
				player.take_damage()
				canDamage = 50
	else:
		canDamage -= 1

func do_state():
	match state:
		NEW_DIR:
			moveDir = choose(dirChoose)
			if moveDir == oldDir:
				choose(dirChoose)
			if moveDir == oldDir:
				choose(dirChoose)
			oldDir = moveDir
			state = MOVE
		MOVE:
			move()
		CHASE:
			move_to_player()
		KNOCKBACK:
			do_knockback()

func flip_sprite():
	if moveDir.x >= 0:
		$Sprite.flip_h = false
	elif moveDir.x < 0:
		$Sprite.flip_h = true

func flip_sprite_to_player():
	var playerPos = global.player.get_global_position()
	var ourPos = get_global_position()
	if playerPos.x > ourPos.x:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true

func move_to_player():
	$AnimationPlayer.play("attack")
	var flyPos = get_global_position()
	var playerPos = global.player.get_global_position()
	var distToPlayer = get_global_position().distance_to(playerPos); 
	var  moveDir = (playerPos - position).normalized() * SPEED
	if distToPlayer < 12:
		state = ATTACK
	flip_sprite_to_player()
	move_and_slide(moveDir, Vector2.ZERO)

func move():
	flip_sprite()
	move_and_slide(moveDir.normalized() *SPEED, Vector2.ZERO)

func choose(array):
	array.shuffle()
	return array.front()

func _on_StateTimer_timeout():
	$StateTimer.wait_time = choose([0.25, 0.5, 0.75])
	if state != CHASE:
		state = choose(stateChooser)

func do_knockback():
	if iframes != 0:
		move_and_slide(knockDir.normalized() * SPEED * 2, Vector2.ZERO)
	else:
		state = choose(stateChooser)

func take_damage():
	if iframes == 0:
		iframes = 15
		hp -= global.player_damage
		if hp <= 0:
			do_death()
		else:
			state = KNOCKBACK

func do_death():
	get_node("Sprite").modulate = Color(10,10,10,10)
	global.enemiesAlive -= 1
	global.money += 5
	#var boom = bloodSplatter.instance()
	#boom.set_position(position)
	#get_parent().add_child(boom)
	#var dead = death.instance()
	#dead.set_position(position)
	#dead.deathName = "KnifeGuy"
	#get_parent().get_node("DeadEnemies").add_child(dead)
	queue_free()
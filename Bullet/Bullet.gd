extends KinematicBody2D

var TYPE = "BULLET"
const speed = 300
var moveDir = Vector2.ZERO
var start_pos = Vector2.ZERO
var canHurt = true
var damage = 0

func ready():
	$LifeTimer.start()

func _physics_process(delta):
	var movement = (moveDir - start_pos).normalized() * speed * delta
	move_and_collide(movement)
	
	if $LifeTimer.is_stopped():
		queue_free()
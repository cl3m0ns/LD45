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

func _on_Hitbox_area_entered(area):
	var body = area.get_parent()
	if body.get("TYPE") == "ENEMY" && canHurt:
		body.knockDir = body.get_global_position() - get_global_position()
		body.take_damage()
		canHurt = false
		#explode_and_die()

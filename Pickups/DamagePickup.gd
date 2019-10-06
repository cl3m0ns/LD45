extends Node2D
var canPickup = false

func _ready():
	$ArrowAnim/AnimationPlayer.play("idle")

func _physics_process(delta):
	if canPickup && Input.is_action_pressed("pickup_item") && global.check_money():
		#DO DAMAGE UP HERE
		
		global.more_damage()
		global.spend_money()
		global.play_pickup()
		
		queue_free()

func _on_Hitbox_area_entered(area):
	var parent = area.get_parent()
	if parent.get("TYPE") == "PLAYER":
		canPickup = true
		$ArrowAnim/AnimationPlayer.play("arrow anim")

func _on_Hitbox_area_exited(area):
	var parent = area.get_parent()
	if parent.get("TYPE") == "PLAYER":
		canPickup = false
		$ArrowAnim/AnimationPlayer.play("idle")
	

extends Node2D
var canPickup = false

func _ready():
	$AnimationPlayer.play("idle")

func _physics_process(delta):
	if canPickup && Input.is_action_pressed("pickup_item"):
		global.update_player_sprite(true)
		queue_free()

func _on_Hitbox_area_entered(area):
	var parent = area.get_parent()
	if parent.get("TYPE") == "PLAYER":
		canPickup = true
		$AnimationPlayer.play("arrow anim")
	else:
		canPickup = false
		$AnimationPlayer.play("idle")

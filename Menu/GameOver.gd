extends Node2D

var color = false

func _ready():
	$BlinkTimer.start()
	$Transition.black_go_out()
	$RoundsSurvived.text = String(global.rounds_survived)

func _physics_process(delta):
	blink_any_key()

func _input(event):
	if event is InputEventKey and event.pressed:
		if $WaitTimer.is_stopped():
			$Transition.black_go_in()
			yield($Transition/AnimationPlayer, "animation_finished")
			global.reset_stats()
			get_tree().change_scene("res://World/World.tscn")

func blink_any_key():
	if $BlinkTimer.is_stopped():
		if color == true:
			color = false
			$anykey1.visible =  true
			$anykey2.visible = false
		else:
			color = true
			$anykey1.visible =  false
			$anykey2.visible = true
		
		$BlinkTimer.wait_time = .75
		$BlinkTimer.start()
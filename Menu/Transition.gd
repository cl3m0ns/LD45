extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func black_go_out():
	$AnimationPlayer.play("black_go_out")
	
func black_go_in():
	$AnimationPlayer.play("black_go_in")

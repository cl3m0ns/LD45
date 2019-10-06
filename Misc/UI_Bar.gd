extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_hp()

func update_hp():
	var hpSprites = $HP.get_children()
	var count = 1
	for i in hpSprites:
		if count <= global.max_hp:
			i.visible = true
		else:
			i.visible = false
		
		if count <= global.hp:
			i.frame = 0
		else:
			i.frame = 1
		count +=1



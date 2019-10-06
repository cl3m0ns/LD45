extends Node2D

func _ready():
	if global.hasShirt && global.hasPants:
		$PantsPickup.queue_free()
		$ShirtPickup.queue_free()
	elif !global.hasShirt:
		$PantsPickup.queue_free()
		$HealthPickup.queue_free()
	elif global.hasShirt && !global.hasPants:
		$ShirtPickup.queue_free()
		$HealthPickup.queue_free()
		
func _die():
	queue_free()
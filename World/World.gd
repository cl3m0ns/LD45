extends Node2D
var arrow = load("res://Misc/1crosshair.png")

func _ready():
    # Changes only the arrow shape of the cursor
    # This is similar to changing it in the project settings
    Input.set_custom_mouse_cursor(arrow)

    # Changes a specific shape of the cursor (here the IBeam shape)
    #Input.set_custom_mouse_cursor(beam, Input.CURSOR_IBEAM)
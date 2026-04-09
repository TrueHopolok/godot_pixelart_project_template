class_name DefaultButton
extends BetterButton


const NORMAL: Texture = preload("res://assets/art/temperary/button_normal.png")
const PRESSED: Texture = preload("res://assets/art/temperary/button_pressed.png")
const HOVERED: Texture = preload("res://assets/art/temperary/button_hovered.png")


func _ready() -> void:
	super()
	if not texture_normal: texture_normal = NORMAL
	if not texture_pressed: texture_pressed = PRESSED
	if not texture_hover: texture_hover = HOVERED

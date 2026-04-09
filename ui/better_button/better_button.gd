class_name BetterButton
extends Button


@export var _press_sfx: AudioStream


func _ready() -> void:
	_set_sfx()
	pressed.connect(_on_press)


## Overridable method that is called on each button press
func _on_press() -> void:
	pass


func _set_sfx() -> void:
	var press_sfx_player := AudioStreamPlayer.new()
	press_sfx_player.stream = _press_sfx
	pressed.connect(press_sfx_player.play)
	add_child(press_sfx_player)

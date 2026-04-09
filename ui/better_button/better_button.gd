class_name BetterButton
extends TextureButton


@export var _button_text: String
@export var _press_sfx: AudioStream


func _ready() -> void:
	stretch_mode = TextureButton.STRETCH_SCALE
	_set_label()
	_set_sfx()
	pressed.connect(_on_press)


## Overridable method that is called on each button press
func _on_press() -> void:
	pass


func _set_label() -> void:
	var text_label := Label.new()

	text_label.set_anchors_preset(Control.PRESET_FULL_RECT)
	# NOTE: text_label.offset_bottom
	text_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	text_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

	text_label.text = _button_text
	add_child(text_label)


func _set_sfx() -> void:
	var press_sfx_player := AudioStreamPlayer.new()
	press_sfx_player.stream = _press_sfx
	pressed.connect(press_sfx_player.play)
	add_child(press_sfx_player)

class_name AudioSlider
extends HSlider



@export var bus_name: StringName
@onready var _audio_settings: AudioSettings = get_tree().get_first_node_in_group("AudioSettings")
var _bus_idx: int


func _ready() -> void:
	_bus_idx = AudioServer.get_bus_index(bus_name)
	assert(_bus_idx >= 0, "Error in audio settings: bus name '%s' does not exists" % bus_name)
	
	if _audio_settings.reset: _set_default(false) # requires a reset of settings
	elif _audio_settings.volumes.has(bus_name): value = _audio_settings.volumes[bus_name] # already has been read
	elif _audio_settings.read() && _audio_settings.volumes.has(bus_name): value = _audio_settings.volumes[bus_name] # value is read from file and was it was found
	else: _set_default(true) # no value found => set default value 

	drag_ended.connect(_on_drag_ended)


func _set_default(save: bool) -> void:
	value = AudioServer.get_bus_volume_linear(_bus_idx)
	_audio_settings.volumes[bus_name] = value
	if save: _audio_settings.save()


func _on_drag_ended(has_changed: bool) -> void:
	if !has_changed: return
	AudioServer.set_bus_volume_linear(_bus_idx, value)
	_audio_settings.volumes[bus_name] = value
	_audio_settings.save()

class_name AudioSlider
extends Slider



@export var bus_name: StringName
@onready var _audio_settings: AudioSettings = get_tree().get_first_node_in_group("AudioSettings")
var _bus_idx: int


func _ready() -> void:
	_bus_idx = AudioServer.get_bus_index(bus_name)
	assert(_bus_idx >= 0, "Error in audio settings: bus name '%s' does not exists" % bus_name)

	if _audio_settings.reset: value = AudioServer.get_bus_volume_linear(_bus_idx)
	else: value = SettingsCfg.config.get_value(_audio_settings.AUDIO_SECTION, bus_name, AudioServer.get_bus_volume_linear(_bus_idx))
	_save_volume()

	drag_ended.connect(_save_volume)


func _save_volume(has_changed: bool = true) -> void:
	if !has_changed: return
	AudioServer.set_bus_volume_linear(_bus_idx, value)
	SettingsCfg.config.set_value(_audio_settings.AUDIO_SECTION, bus_name, value)
	SettingsCfg.config.save(SettingsCfg.CFG_PATH)

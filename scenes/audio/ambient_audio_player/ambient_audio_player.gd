class_name AmbientAudioPlayer
extends AudioStreamPlayer


@export_group('General')
@export_range(1, 360, 1) var _min_delay: float = 15.0
@export_range(1, 360, 1) var _max_delay: float = 60.0
@export var _ambient_sounds: Array[AudioStream]

@export_group('Panning')
@export var _enable_bus_panning: bool = false
@export_range(0.0, 1.0, 0.05) var _min_panning: float = 0.0
@export_range(0.0, 1.0, 0.05) var _max_panning: float = 0.5
@export var _reset_panning_on_play: bool = false

var _effect_panner: AudioEffectPanner
var _timer_player: Timer


func _ready() -> void:
	if bus != &"SFX" && bus != &"SFX_panning": printerr("Ambience Audio Player is not set on SFX bus")

	_timer_player = Timer.new()
	_timer_player.one_shot = true
	add_child(_timer_player)
	_timer_player.timeout.connect(_play_sound)
	finished.connect(_start_timer)
	_start_timer()

	if _enable_bus_panning:
		if bus != &"SFX_panning":
			printerr("Ambience Audio Player is not set on SFX_panning bus\nenable panning is disabled")
			_enable_bus_panning = false
			return
		var bus_idx: int = AudioServer.get_bus_index(bus)
		if AudioServer.get_bus_effect_count(bus_idx) != 1:
			printerr("SFX_panning bus has invalid amount of effects\nenable panning is disabled")
			_enable_bus_panning = false
			return
		var effect: AudioEffect = AudioServer.get_bus_effect(bus_idx, 0)
		if !is_instance_of(effect, AudioEffectPanner):
			printerr("SFX_panning bus has invalid effect\nenable panning is disabled")
			_enable_bus_panning = false
			return
		_effect_panner = effect


func _play_sound() -> void:
	stream = _ambient_sounds.pick_random()
	if _enable_bus_panning:
		if _reset_panning_on_play: _effect_panner.pan = 0.5
		var tween = get_tree().create_tween()
		var _delta_pan: float = randf_range(_min_panning, _max_panning) * [-1.0, 1.0].pick_random()
		tween.tween_property(_effect_panner, ^'pan', _delta_pan, stream.get_length())
	play()


func _start_timer() -> void:
	_timer_player.start(randf_range(_min_delay, _max_delay))

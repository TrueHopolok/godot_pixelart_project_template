class_name AudioSettings
extends VBoxContainer


const AUDIO_CFG_PATH: String = "user://audio.json"

## Will reset all audio settings by deleteing file at AUDIO_CFG_PATH
@export var reset: bool = false
var volumes: Dictionary = {}


## Its executes after volume slider, so reset property is read by slider to decide what todo
func _ready() -> void:
	if reset:
		DirAccess.remove_absolute(AUDIO_CFG_PATH)
		print("Warning in Audio Settings: varaible reset is set to true, remove it asap")


## Saves current situation of volume
func save() -> void:
	var file: FileAccess = FileAccess.open(AUDIO_CFG_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(volumes))
	file.close()
	#print("Audio settings: SAVED")
	#print(volumes)


## Reads volumes from saved file.
## Returns true if successeded.
## Returns false if not file was found.
func read() -> bool:
	if not FileAccess.file_exists(AUDIO_CFG_PATH): return false
	var file: FileAccess = FileAccess.open(AUDIO_CFG_PATH, FileAccess.READ)
	volumes = JSON.parse_string(file.get_as_text())
	file.close()
	#print("Audio settings: READ")
	#print(volumes)
	return true

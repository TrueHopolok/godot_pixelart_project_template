extends Node


const SAVE_PATH: String = "user://bestscore.bin"


var best_score: int = 0
var current_score: int = 0


func _init() -> void:
	_load()


## Loads score or set to default
func _load() -> void:
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		var err: Error = FileAccess.get_open_error()
		if err != ERR_FILE_NOT_FOUND: printerr("Persistence loading error:", FileAccess.get_open_error())
		return
	# NOTE: data = JSON.parse_string(file.get_as_text())
	best_score = file.get_32()
	file.close()


## Saves best score from memory to file
func _save() -> void:
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if not file:
		printerr("Persistence saving error:", FileAccess.get_open_error())
		return
	# NOTE: file.store_string(JSON.stringify(data))
	file.store_32(best_score)
	file.close()


## Updates best score if was beaten and saves  into file if it was
func submit() -> void:
	if current_score <= best_score: return
	best_score = current_score
	_save()


## Resets best score back to 0 both in memory and in file
func reset() -> void:
	best_score = -1
	current_score = 0
	submit()

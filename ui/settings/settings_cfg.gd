extends Node


const CFG_PATH: String = "user://settings.cfg"

var config: ConfigFile


func _init() -> void:
	config = ConfigFile.new()
	var err: Error = config.load(CFG_PATH)
	if err != Error.OK and err != Error.ERR_FILE_NOT_FOUND: printerr("Error reading settings config: ", err)

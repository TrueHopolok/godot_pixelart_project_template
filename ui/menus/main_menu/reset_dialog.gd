extends ConfirmationDialog


func _ready() -> void:
	confirmed.connect(
		func() -> void:
			Persistence.reset()
			Transition.reload_scene()
	)

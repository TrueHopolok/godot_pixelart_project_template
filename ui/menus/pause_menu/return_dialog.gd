extends ConfirmationDialog


func _ready() -> void:
	confirmed.connect(
		func() -> void:
			Transition.change_scene_path('res://ui/menus/main_menu/main_menu.tscn')
	)

extends DefaultButton


func _on_press() -> void:
	Transition.change_scene_path('res://scenes/test_scene.tscn')

extends CanvasLayer


func _process(_delta: float) -> void:
	visible = get_tree().paused
	$BG.visible = visible


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&'pause_game'):
		for child: Node in $ContinueButton.get_children():
			if is_instance_of(child, AudioStreamPlayer):
				child.play()
		get_tree().paused = !get_tree().paused
